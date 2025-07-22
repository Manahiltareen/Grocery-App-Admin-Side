import 'package:flutter/material.dart';
import 'package:grocery_app_admin/Constant/theme/app_theme.dart';
import 'package:grocery_app_admin/View/widegts/category_list_item.dart';

class ManageCategoriesScreen extends StatefulWidget {
  const ManageCategoriesScreen({super.key});

  @override
  State<ManageCategoriesScreen> createState() => _ManageCategoriesScreenState();
}

class _ManageCategoriesScreenState extends State<ManageCategoriesScreen> {
  final List<Map<String, dynamic>> _categories = [
    {
      'id': '1',
      'name': 'Fruits',
      'image': 'assets/Download sushi platter with different types of sushi for free.jpeg',
      'bgColor': AppTheme.primaryColor,
      'unit': 'kg'
    },
    {
      'id': '2',
      'name': 'Vegetables',
      'image': 'assets/Robot Verification.jpeg',
      'bgColor': AppTheme.accentColor,
      'unit': 'pcs'
    },
    {
      'id': '3',
      'name': 'Dairy & Eggs',
      'image': 'assets/Sandwich vector illustration clean line and cool color clip art for menu poster web.jpeg',
      'bgColor': AppTheme.secondaryAccentColor,
      'unit': 'liters'
    },
  ];

  void _addCategory() {
    Navigator.pushNamed(context, '/add_edit_category', arguments: {'type': 'add'}).then((result) {
      if (result != null) {
        debugPrint('New category added: $result');
      }
    });
  }

  void _editCategory(Map<String, dynamic> category) {
    Navigator.pushNamed(context, '/add_edit_category', arguments: {'type': 'edit', 'category': category}).then((result) {
      if (result != null) {
        debugPrint('Category updated: $result');
      }
    });
  }

  void _deleteCategory(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete', style: TextStyle(color: Colors.white)),
        content: const Text('Are you sure you want to delete this category?', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryColor,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _categories.removeWhere((cat) => cat['id'] == id);
              });
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Category deleted successfully!', style: TextStyle(color: Colors.white)), backgroundColor: AppTheme.primaryColor),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Manage Categories', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return SizedBox(
                height: 100,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [category['bgColor'].withOpacity(0.3), Colors.white.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: category['bgColor'].withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: category['bgColor'].withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.network(category['image'], color: Colors.white, colorBlendMode: BlendMode.modulate),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(category['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87)),
                              Text('Unit: ${category['unit']}', style: const TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.green),
                              onPressed: () => _editCategory(category),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteCategory(category['id']!),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _addCategory,
              backgroundColor: AppTheme.primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}