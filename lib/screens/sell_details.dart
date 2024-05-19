// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart'; // Ensure this import is correct
import 'package:project_week8/screens/Home_Screen.dart';
import 'package:project_week8/screens/selldetail_screen.dart';

class SellDetails extends StatefulWidget {
  const SellDetails({Key? key}) : super(key: key);

  @override
  State<SellDetails> createState() => _SellDetailsState();
}

class _SellDetailsState extends State<SellDetails> {
  @override
  void initState() {
    saveSellProduct();
    super.initState();
  }

  // ignore: unused_element
  Future<void> _deleteSellProduct(int id) async {
    await deleteSellproduct(id); // Calling your delete function from db_functions.dart
    // No need to call setState() here, because sell.notifyListeners() in deleteSellProduct will update the UI.
  }

  void _showDeleteConfirmationDialog(BuildContext context, SellProductModel sellProduct) {
    showDialog(
      context: context,
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
              onPressed: () {
                Navigator.of(context).pop();
                // deleteSellProduct(sellProduct.id);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Sell Details',
        style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScreenHome()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder<List<SellProductModel>>(
          valueListenable: sell, // Assuming sell is a ValueNotifier containing the list of sell products
          builder: (context, sellProducts, _) {
            if (sellProducts.isNotEmpty) {
              return ListView.builder(
                itemCount: sellProducts.length,
                itemBuilder: (context, index) {
                  final sellProduct = sellProducts[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to a new screen to display the details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellDetailScreen(sellProduct: sellProduct),
                        ),
                      );
                    },
                    onLongPress: () {
                    
                      _showDeleteConfirmationDialog(context, sellProduct);
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${sellProduct.name}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Product: ${sellProduct.product}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Price: \$${sellProduct.price.toString()}',
                              style: const TextStyle(fontSize: 16, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No sell details available'));
            }
          },
        ),
      ),
    );
  }
}
