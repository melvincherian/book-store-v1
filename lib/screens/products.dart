import 'package:flutter/material.dart';

class ScreenProduct extends StatelessWidget {
  const ScreenProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 242, 242),
        title: const Text(
          'Products',
          style: TextStyle(fontSize: 38, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Divider(height: 1, color: Colors.grey), // Divider between AppBar and search controller
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add), // Change the icon as needed
        backgroundColor: Colors.blue, // Change the background color as needed
      ),
    );
  }
}
