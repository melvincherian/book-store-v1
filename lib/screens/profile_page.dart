// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:project_week8/screens/About_Screen.dart';
import 'package:project_week8/screens/Edit_Profile.dart';
import 'package:project_week8/screens/Home_Screen.dart';
import 'package:project_week8/screens/Login_Screen.dart';
import 'package:project_week8/screens/Privacy_Screen.dart';
import 'package:project_week8/screens/Sell_Product.dart';
import 'package:project_week8/screens/Terms_Service.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScreenHome()),
            );
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsOverlayScreen(),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: const Icon(Icons.settings, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.04),
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.05),
            CircleAvatar(
              radius: screenSize.width * 0.2,
              backgroundImage: const AssetImage(
                'assets/images/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg',
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            const Text(
              'Melvin Cherian',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            SizedBox(
              width: screenSize.width * 0.6,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfile()),
                  );
                },
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            _buildListTile(
              icon: Icons.shop,
              title: 'Sell Products',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SellProduct()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.security,
              title: 'Privacy Policy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScreenPrivacy()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.policy,
              title: 'Terms of Services',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScreenTerms()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.info,
              title: 'About',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(
      {required IconData icon, required String title, required Function() onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blue,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
      onTap: onTap,
    );
  }
}

class SettingsOverlayScreen extends StatelessWidget {
  const SettingsOverlayScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _showLogoutConfirmation(context);
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                label: const Text(
                  'Log out',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement share functionality
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.black,
                ),
                label: const Text(
                  'Share App',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const ScreenLogin()),
                  (route) => false,
                );
              },
              child: const Text(
                'Log Out',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        );
      },
    );
  }
}
