// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ScreenFavourite extends StatefulWidget {
  const ScreenFavourite({Key? key}) : super(key: key);

  @override
  _ScreenFavouriteState createState() => _ScreenFavouriteState();
}

class _ScreenFavouriteState extends State<ScreenFavourite> {
  List<FavoriteItem> favoriteItems = [
    FavoriteItem('Heart of Darkness', 'JOSEPH CONRAD'),
    FavoriteItem('Harry Potter', 'JK ROWLING'),
    FavoriteItem('Atomic Habits', 'JAMES CLEAR')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(
              fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favoriteItems.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildFavoriteItem(favoriteItems[index]);
        },
      ),
    );
  }

  Widget _buildFavoriteItem(FavoriteItem item) {
    return Card(
        color: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/book3.jpg'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              item.author,
              style: const TextStyle(color: Color.fromARGB(255, 32, 30, 30), fontSize: 14),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onPressed: () {
                _deleteFavoriteItem(item);
              },
            ),
          ],
        ),
        onTap: () {
          // Handle onTap action
        },
      ),
    );
  }

  void _deleteFavoriteItem(FavoriteItem item) {
    setState(() {
      favoriteItems.remove(item);
    });
    _showDeleteSnackbar(context, item.title, item.author);
  }

  void _showDeleteSnackbar(BuildContext context, String title, String author) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted: $title by $author'),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            _undoDelete(title, author);
          },
        ),
      ),
    );
  }

  void _undoDelete(String title, String author) {
    setState(() {
      favoriteItems.add(FavoriteItem(title, author));
    });
  }
}

class FavoriteItem {
  final String title;
  final String author;

  FavoriteItem(this.title, this.author);
}
