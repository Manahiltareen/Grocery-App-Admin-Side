// screens/add_edit_category_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:grocery_app_admin/Constant/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddEditCategoryScreen extends StatefulWidget {
  const AddEditCategoryScreen({super.key});

  @override
  State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _pickedImage;
  Color _selectedColor = AppTheme.primaryColor;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  bool _isEditing = false;
  Map<String, dynamic>? _initialCategoryData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      if (args['type'] == 'edit') {
        _isEditing = true;
        _initialCategoryData = args['category'];
        _nameController.text = _initialCategoryData!['name'];
        _unitController.text = _initialCategoryData!['unit'];
        _selectedColor = _initialCategoryData!['bgColor'];
        // For image, if it's a file path or network image, you'd handle it here.
        // For this demo, we'll assume new image selection for simplicity or use placeholder.
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select a Color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _selectedColor,
            onColorChanged: (color) {
              setState(() {
                _selectedColor = color;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _saveCategory() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you would send data to your backend or update state
      final categoryData = {
        'id': _isEditing ? _initialCategoryData!['id'] : const Uuid().v4(), // Generate new ID if adding
        'name': _nameController.text,
        'unit': _unitController.text,
        'bgColor': _selectedColor,
        'image': _pickedImage?.path, // In a real app, upload this image
      };

      Navigator.of(context).pop(categoryData); // Return data to previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Category' : 'Add Category'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category Image',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: _pickedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _pickedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                        : (_isEditing && _initialCategoryData!['image'] != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        _initialCategoryData!['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image, size: 50, color: AppTheme.lightTextColor),
                      ),
                    )
                        : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, size: 50, color: AppTheme.lightTextColor),
                        SizedBox(height: 8),
                        Text('Upload Image', style: TextStyle(color: AppTheme.lightTextColor)),
                      ],
                    )),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Background Color',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _showColorPicker,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: _selectedColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Tap to select color',
                    style: TextStyle(
                      color: _selectedColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  hintText: 'e.g., Fruits',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _unitController,
                decoration: const InputDecoration(
                  labelText: 'Unit (e.g., kg, pcs)',
                  hintText: 'e.g., kg',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a unit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _saveCategory,
                    child: Text(_isEditing ? 'Save Changes' : 'Add Category'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}