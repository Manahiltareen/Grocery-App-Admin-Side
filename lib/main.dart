// main.dart
import 'package:flutter/material.dart';

import 'package:grocery_app_admin/Constant/theme/app_theme.dart';
import 'package:grocery_app_admin/View/Category/add_edit_category_screen.dart';
import 'package:grocery_app_admin/View/Category/manage_categories_screen.dart';
import 'package:grocery_app_admin/View/Home/admin_dash_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery Admin Dashboard',
      theme: AppTheme.lightTheme,
      home: const AdminDashboardScreen(),
      routes: {
        '/manage_categories': (context) => const ManageCategoriesScreen(),
        '/add_edit_category': (context) => const AddEditCategoryScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}