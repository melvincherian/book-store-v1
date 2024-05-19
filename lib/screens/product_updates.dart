// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_week8/screens/Home_Screen.dart';


class ScreenUpdate extends StatelessWidget {
  const ScreenUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    // Assume this variable indicates whether stocks are available or not
    bool stocksAvailable = false;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon:
                      const Icon(Icons.arrow_back), // You can use any icon here
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenHome()));
                  },
                ),
                const SizedBox(width: 88),
                const Text(
                  'Stock Updates ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: stocksAvailable
                // ignore: dead_code
                ? Container(
                    // Widget for displaying stock updates
                    )
                : const Center(
                    child: Text(
                      'No stocks available',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
