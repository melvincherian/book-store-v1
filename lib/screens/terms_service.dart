// ignore_for_file: file_names, unused_element

import 'package:flutter/material.dart';
import 'package:project_week8/screens/Profile_Page.dart';

class ScreenTerms extends StatelessWidget {
  const ScreenTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsOverlayScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Terms and Service',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const _SectionTitle('1. Use of the app'),
              const _SectionText(
                'The app is intended solely for use by shop owners for managing their inventory. '
                'You agree to use the app in accordance with these terms and all applicable laws and regulations.',
              ),
              const Divider(),
              const _SectionTitle('2. Account Registration'),
              const _SectionText(
                'You need to register for an account to access certain features of the app. '
                'You agree to provide accurate and complete information when creating an account.',
              ),
              const Divider(),
              const _SectionTitle('3. User Content'),
              const _SectionText(
                'You may be able to submit content to the app such as product descriptions and inventory data. '
                'You retain ownership of any User Content you submit but grant us a non-exclusive, royalty-free, '
                'and fully sublicensable right to use it in connection with the app.',
              ),
              const Divider(),
              const _SectionTitle('4. Limitations and Liability'),
              const _SectionText(
                'To the fullest extent permitted by law, we disclaim all warranties, express or implied, regarding the app and its content. '
                'We will not be liable for any direct or indirect incidental damages related to your use of the app.',
              ),
              const Divider(),
              const _SectionTitle('5. Termination'),
              const _SectionText(
                'We reserve the right to terminate or suspend your access to the app without cause. '
                'Upon termination, your right to use the app will cease immediately.',
              ),
              const Divider(),
              const _SectionTitle('6. Changes to the terms'),
              const _SectionText(
                'We may revise these terms at any time by updating this page.',
              ),
              const Divider(),
              const _SectionTitle('7. Contact us'),
              const _SectionText(
                'If you have any questions or concerns about these Terms, please contact us at [Your contact information].',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _SectionText extends StatelessWidget {
  final String text;
  const _SectionText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
