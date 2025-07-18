// screens/admin_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:grocery_app_admin/View/widegts/dashboard_card.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Handle profile tap
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          children: [
            DashboardCard(
              icon: Icons.shopping_cart,
              title: 'Orders',
              subtitle: 'Manage customer orders',
              onTap: () {
                // Navigate to Orders screen
              },
            ),
            DashboardCard(
              icon: Icons.inventory_2,
              title: 'Products',
              subtitle: 'View and update inventory',
              onTap: () {
                // Navigate to Products screen
              },
            ),
            DashboardCard(
              icon: Icons.category,
              title: 'Categories',
              subtitle: 'Organize product categories',
              onTap: () {
                Navigator.pushNamed(context, '/manage_categories');
              },
            ),
            DashboardCard(
              icon: Icons.people,
              title: 'Customers',
              subtitle: 'Manage user accounts',
              onTap: () {
                // Navigate to Customers screen
              },
            ),
            DashboardCard(
              icon: Icons.notifications,
              title: 'Notifications',
              subtitle: 'Send alerts and updates',
              onTap: () {
                // Navigate to Notifications screen
              },
            ),
          ],
        ),
      ),
    );
  }
}