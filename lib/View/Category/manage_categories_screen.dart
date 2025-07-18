// screens/manage_categories_screen.dart
import 'package:flutter/material.dart';
import 'package:grocery_app_admin/Constant/theme/app_theme.dart';
import 'package:grocery_app_admin/View/widegts/category_list_item.dart';


class ManageCategoriesScreen extends StatefulWidget {
  const ManageCategoriesScreen({super.key});

  @override
  State<ManageCategoriesScreen> createState() => _ManageCategoriesScreenState();
}

class _ManageCategoriesScreenState extends State<ManageCategoriesScreen> {
  // Dummy data for demonstration
  final List<Map<String, dynamic>> _categories = [
    {
      'id': '1',
      'name': 'Fruits',
      'image': 'https://via.placeholder.com/60/5BBA72/FFFFFF?text=F',
      'bgColor': AppTheme.primaryColor,
      'unit': 'kg'
    },
    {
      'id': '2',
      'name': 'Vegetables',
      'image': 'https://via.placeholder.com/60/F16E4F/FFFFFF?text=V',
      'bgColor': AppTheme.accentColor,
      'unit': 'pcs'
    },
    {
      'id': '3',
      'name': 'Dairy & Eggs',
      'image': 'https://via.placeholder.com/60/D6B5DA/FFFFFF?text=D',
      'bgColor': AppTheme.secondaryAccentColor,
      'unit': 'liters'
    },
  ];

  void _addCategory() {
    Navigator.pushNamed(context, '/add_edit_category', arguments: {'type': 'add'}).then((result) {
      if (result != null) {
        // Handle new category added, e.g., refresh list
        // For now, just print
        debugPrint('New category added: $result');
        // In a real app, you'd update the state or fetch data
      }
    });
  }

  void _editCategory(Map<String, dynamic> category) {
    Navigator.pushNamed(context, '/add_edit_category', arguments: {'type': 'edit', 'category': category}).then((result) {
      if (result != null) {
        // Handle category updated, e.g., refresh list
        debugPrint('Category updated: $result');
        // In a real app, you'd update the state or fetch data
      }
    });
  }

  void _deleteCategory(String id) {
    // Implement delete logic, e.g., show confirmation dialog
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this category?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _categories.removeWhere((cat) => cat['id'] == id);
              });
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Category deleted successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Categories'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: _addCategory,
              icon: const Icon(Icons.add),
              label: const Text('Add New Category'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      body: _categories.isEmpty
          ? const Center(
        child: Text(
          'No categories found. Click "Add New Category" to add one.',
          style: TextStyle(fontSize: 16, color: AppTheme.lightTextColor),
          textAlign: TextAlign.center,
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return CategoryListItem(
            category: category,
            onEdit: () => _editCategory(category),
            onDelete: () => _deleteCategory(category['id']!),
          );
        },
      ),
    );
  }
}