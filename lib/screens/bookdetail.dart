import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> details;

  const DetailsPage({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: 400,
          height: 480,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailItem(
                label: 'Author:',
                value: '${details['author']}',
              ),
              DetailItem(
                label: 'Book Name:',
                value: '${details['bookName']}',
              ),
              DetailItem(
                label: 'Price:',
                value: '${details['price']}',
              ),
              DetailItem(
                label: 'Volume:',
                value: '${details['volume']}',
              ),
              DetailItem(
                label: 'Count:',
                value: '${details['count']}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const DetailItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
