// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_week8/screens/Profile_Page.dart';

class ScreenTerms extends StatelessWidget {
  const ScreenTerms({super.key});

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
                                builder: (context) =>  SettingsOverlayScreen()));
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Terms and Service',
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
                    '1.Use of the app',
                    style: TextStyle(
                        fontSize: 24,
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
                    '.The app is intended solely for use by shop owners for\nmanaging their inventory\n.You agree to use the app in accordance with these\nterms and all applicable laws and regulations',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    '2.Account Registration',
                    style: TextStyle(
                        fontSize: 24,
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
                    '.You need to register for an account to access certain\nfeatures of the app\n.You agree to provide accurate and complete information\nwhen creating an account ',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    '3.User Content',
                    style: TextStyle(
                        fontSize: 24,
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
                    '.You may be able to submit content to the app such as\nproduct description and inventory data\n.You retain ownership for any User Content You submit\nbut submitting the user content You grant us a exclusive\nroyal free and fully sublicensable right to use to connection\nwith the app',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    '4.Limitations and Liability',
                    style: TextStyle(
                        fontSize: 24,
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
                    '.To the fullest extent permitted by the law we disclaim \nall the warranties,express or implied regarding the app\n and its content\n.We will not be liable for any direct or indirect\nincidental in any way related to your use of the app ',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  SizedBox(width: 16),
                  Text(
                    '5.Termination',
                    style: TextStyle(
                        fontSize: 24,
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
                    '.We Reserve the right to terminate or suspend your \naccess to the app without any cause\n.Upon the termination you right to use the App will\n cease immideatly',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )
                ],
              ),
              const Divider(),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    '6.Changes the terms',
                    style: TextStyle(
                        fontSize: 24,
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
                    'We may revice these terms at any time by updating\n these page. ',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    '7.Contact us',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  SizedBox(width: 17),
                  Text(
                    '.If you have any questions or concerns about these\nTerms Please contact us[Your contact information] ',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
