// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_week8/screens/Profile_Page.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SettingsOverlayScreen()));
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    const Text(
                      'About Our App',
                      style: TextStyle(
                          fontSize: 38,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    'About the app',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  SizedBox(width: 19),
                  Text(
                    'Our inventory management application is designed \nSpecifically for shop owners to efficiently manage \ntheir inventory with different features and user\nfriendly interface it is mainly process of managing\nstock levels and all.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    'Features of the app:',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    '1.Sales anayltics and reporting tools\n2.Real-time Tracking of inventory levels\n3.Notification for no stock items\n4.Easy product and organisation',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  )
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              const Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    '',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
