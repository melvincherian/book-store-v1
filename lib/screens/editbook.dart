import 'package:flutter/material.dart';

class EditBook extends StatelessWidget {
  const EditBook({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:const Text('Edit Book',
        style: TextStyle(fontSize: 36,color: Colors.black,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    );
  }
}