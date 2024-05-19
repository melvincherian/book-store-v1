// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:hive/hive.dart';
import 'package:project_week8/functions/db_functions.dart';

class SellDetailScreen extends StatelessWidget {
  final SellProductModel sellProduct;

  const SellDetailScreen({Key? key, required this.sellProduct}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: GestureDetector(
            onLongPress: () async {
              await _showDeleteConfirmationDialog(context);
            },
            child: Card(
              color: const Color.fromARGB(255, 248, 220, 220),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildInfoItem(
                      label: 'Name:',
                      value: sellProduct.name,
                    ),
                    const Divider(),
                    _buildInfoItem(
                      label: 'Phone Number:',
                      value: sellProduct.phonenumber,
                    ),
                    const Divider(),
                    _buildInfoItem(
                      label: 'Product:',
                      value: sellProduct.product,
                    ),
                    const Divider(),
                    _buildInfoItem(
                      label: 'Discount:',
                      value: '${sellProduct.discount}%',
                    ),
                    const Divider(),
                    _buildInfoItem(
                      label: 'Price:',
                      value: '\$${sellProduct.price.toString()}',
                    ),
                    const SizedBox(height: 20.0),
                    _buildInfoItem(
                      label: 'Date:',
                      value: DateTime.now().toLocal().toString().split(' ')[0],
                      italic: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required String label,
    required String value,
    bool italic = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          text: '$label ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                // await deleteSellproduct(sellProduct.id);
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Close the detail screen
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteSellproduct(int id) async {
    final sellDB = await Hive.openBox<SellProductModel>('sell value');
    await sellDB.delete(id);
    sell.value.removeWhere((element) => element.id == id);
    sell.notifyListeners();
  }
}
