import 'package:flutter/material.dart';

import 'user_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            // Account Section

            _buildSectionTitle('Account'),
            _buildCard(
              context: context,
              title: 'Profile',
              icon: Icons.person,
              onTap: () {
                // Navigate to Profile Page
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => UserPage()),
                );
              },
            ),
            _buildCard(
              context: context,
              title: 'Order History',
              icon: Icons.history,
              onTap: () {
                // Navigate to Order History Page
              },
            ),

            // Notifications Section
            _buildSectionTitle('Notifications'),
            _buildSwitchCard(
              context: context,
              title: 'Enable Notifications',
              value: true, // This should be managed by your state management
              onChanged: (bool value) {
                // Handle toggle
              },
            ),

            // Language Section
            _buildSectionTitle('Language'),
            _buildCard(
              context: context,
              title: 'Select Language',
              icon: Icons.language,
              onTap: () {
                // Navigate to Language Selection Page
              },
            ),

            // Logout Button
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Handle logout
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.black12
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24, color: Colors.white), // Optional: Set text color
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.black54, // Set the card color to match the theme
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.white)), // Set text color
        leading: Icon(icon, color: Colors.white), // Set icon color
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchCard({
    required BuildContext context,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      color: Colors.black54, // Set the card color to match the theme
      child: SwitchListTile(
        title: Text(title, style: TextStyle(color: Colors.white)), // Set text color
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
