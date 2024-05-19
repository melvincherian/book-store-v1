// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_week8/screens/Profile_Page.dart';


class ScreenPrivacy extends StatelessWidget {
  const ScreenPrivacy({super.key});

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
                                builder: (context) => const ScreenProfile()));
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    const Text(
                      'Privacy Policy',
                      style: TextStyle(
                          fontSize: 38,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    'Data Security:',
                    style: TextStyle(
                        fontSize: 20,
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
                    'We provide security measures to protect against\nunauthorized access,disclosure,or destruction\nof user data',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    'No Sharing of personal information:',
                    style: TextStyle(
                        fontSize: 20,
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
                    'We donot sell,trade user information\nto third parties',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    'Changes to policy:',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    'We may update this policy users are encouraged \nto review it periodically',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    'Acceptance of Term:',
                    style: TextStyle(
                        fontSize: 20,
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
                    'By using our app, you agree to the terms \noutlined on this policy',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    'How we use your information:',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    'We use collected information to improve our app\npersonalize user experience ,and communicate \nessential updates or services',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    'Contact us:',
                    style: TextStyle(
                        fontSize: 20,
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
                    'For any concerns you can contact me with your\ncompany name,address etc',
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
