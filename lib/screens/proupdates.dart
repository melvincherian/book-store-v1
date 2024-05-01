import 'package:flutter/material.dart';
import 'package:project_week8/screens/home.dart';

class ScreenUpdate extends StatelessWidget {
  const ScreenUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back), // You can use any icon here
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ScreenHome()));
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
            child: Container(), // Add other widgets or content here
          ),
        ],
      ),
    );
  }
}
