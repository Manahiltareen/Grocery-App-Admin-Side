import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_admin/Constant/theme/app_theme.dart';
import 'package:grocery_app_admin/View/Category/manage_categories_screen.dart';
import 'package:grocery_app_admin/View/widegts/dashboard_card.dart';


class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withOpacity(0.9),
                  AppTheme.primaryColor.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Admin Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = (constraints.maxWidth / 300).floor(); // Approx 300px per card
                  crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount > 4 ? 4 : crossAxisCount;
                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      DashboardCard(
                        icon: Icons.category,
                        title: 'Categories',
                        subtitle: 'Manage categories',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ManageCategoriesScreen()));
                        },
                      ),
                      DashboardCard(
                        icon: Icons.shop,
                        title: 'Products',
                        subtitle: 'Manage products',
                        onTap: () {},
                      ),
                      DashboardCard(
                        icon: Icons.person,
                        title: 'Users',
                        subtitle: 'Manage users',
                        onTap: () {},
                      ),
                      DashboardCard(
                        icon: Icons.local_shipping,
                        title: 'Orders',
                        subtitle: 'View orders',
                        onTap: () {},
                      ),
                      DashboardCard(
                        icon: Icons.bar_chart,
                        title: 'Reports',
                        subtitle: 'View reports',
                        onTap: () {},
                      ),
                      DashboardCard(
                        icon: Icons.settings,
                        title: 'Settings',
                        subtitle: 'Configure settings',
                        onTap: () {},
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}