import 'package:flutter/material.dart';

class ScreenFavourite extends StatelessWidget {
  const ScreenFavourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 249, 237, 218),
        title: const Text(
          'Favorites',
          style: TextStyle(fontSize: 35, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 13),
          ListTile(
            leading: const CircleAvatar(
              radius:
                  30, // Increase the radius to increase the size of the avatar
              backgroundImage: AssetImage('assets/images/book3.jpg'),
              // Replace with your image asset
            ),
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Heart of Darkness',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'JOSEPH CONRAD',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
            onTap: () {},
          ),
          const SizedBox(height: 23),
          ListTile(
            leading: const CircleAvatar(
              radius:
                  30, // Increase the radius to increase the size of the avatar
              backgroundImage: AssetImage(
                  'assets/images/minalima_hp1_flat_compressed-f9e6bda269a545a28f8bd9e50ed5f70b.jpg'),
              // Replace with your image asset
            ),
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Harry Potter',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'JK ROWLING',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ), // Add your desired icon here
              onPressed: () {
                // Handle icon tap action
              },
            ),
            onTap: () {
              // Handle onTap action
            },
          ),
          const SizedBox(height: 23),
          ListTile(
            leading: const CircleAvatar(
              radius:
                  30, // Increase the radius to increase the size of the avatar
              backgroundImage: AssetImage('assets/images/harry4.jpg'),
              // Replace with your image asset
            ),
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Harry Potter',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'JK ROWLING',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ), // Add your desired icon here
              onPressed: () {
                // Handle icon tap action
              },
            ),
            onTap: () {
              // Handle onTap action
            },
          ),
          const SizedBox(height: 23),
          ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage:
                  AssetImage('assets/images/Ile_Mysterieuse_02.jpg'),
            ),
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mysterious',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'James',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
            onTap: () {
              // Handle onTap action
            },
          ),
          // Add more list items as needed
        ],
      ),
    );
  }
}
