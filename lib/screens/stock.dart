import 'package:flutter/material.dart';

class Stock extends StatelessWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title:const Text('Stock Details'),
          centerTitle: true,
      ),
      
    );
  }
}