// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, sort_child_properties_last, unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';
import 'package:project_week8/screens/Addbook_Screen.dart';
import 'package:project_week8/screens/Book_Details.dart';
import 'package:project_week8/screens/Editbook_Screen.dart';

class AddCategory extends StatefulWidget {
  final List<String> addedCategoryNames;
  const AddCategory({Key? key, required this.addedCategoryNames})
      : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> savedDetailsList = [];
  List<Map<String, dynamic>> filteredList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 107, 161, 254),
        title: const Text(
          'Books',
          style: TextStyle(
              fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: savedDetailsList.isEmpty
          ? const Center(
              child:
                  Text('No books added yet', style: TextStyle(fontSize: 18.0)))
          : Column(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        filteredList = savedDetailsList
                            .where((detail) =>
                                detail['bookName']
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                detail['author']
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search books...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: filteredList.isEmpty
                      ? const Center(
                          child: Text('No books found',
                              style: TextStyle(fontSize: 18.0)))
                      : ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final savedDetails = filteredList[index];
                            return GestureDetector(
                              onTap: () => _navigateToDetailsPage(savedDetails),
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (savedDetails['image'] != null)
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.file(
                                          savedDetails['image'],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      const    SizedBox(height: 10),
                                          Text('${savedDetails['bookName']}',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 10),
                                          Text('MRP: ${savedDetails['price']}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey)),
                                          const SizedBox(height: 4),
                                          Text(
                                              'Count: ${savedDetails['count']}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton(
                                      icon: const Icon(Icons.more_vert),
                                      itemBuilder: (BuildContext context) => [
                                        const PopupMenuItem(
                                            value: "edit", child: Text("Edit")),
                                        const PopupMenuItem(
                                            value: "delete",
                                            child: Text("Delete")),
                                      ],
                                      onSelected: (value) {
                                        if (value == "edit") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const EditBook()));
                                        } else if (value == "delete") {
                                          _showDeleteConfirmationDialog(
                                              savedDetails);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddBookPage(
                      addedCategoryNames:
                          widget.addedCategoryNames.toSet().toList(),
                    )),
          );
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              savedDetailsList.add(result);
              filteredList = savedDetailsList
                  .where((detail) =>
                      detail['bookName']
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase()) ||
                      detail['author']
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase()))
                  .toList();
            });
            await addProduct(ProductModel(
                bookname: result['bookName'],
                authorname: result['author'],
                price: result['price'],
                volume: result['volume'],
                count: result['count'],
                categoryName: result['category'],
                id: result['id']));
            await saveProduct();
           
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void _navigateToDetailsPage(Map<String, dynamic> details) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage(details: details)),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      Map<String, dynamic> details) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this product?'),
              ],
            ),
          ),
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
                setState(() {
                 
                  savedDetailsList.remove(details);
                  filteredList = savedDetailsList
                      .where((detail) =>
                          detail['bookName']
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()) ||
                          detail['author']
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                      .toList();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteProduct(int id) async {
    final productDB = await Hive.openBox<ProductModel>('product value');

    // Retrieve the product from product.value list based on ID
    final ProductModel productToDelete = product.value.firstWhere(
      (product) => product.id == id,
      orElse: () => ProductModel(
          bookname: 'bookname',
          authorname: 'authorname',
          price: 'price',
          volume: '1',
          count: '5',
          categoryName: 'category name',
          id: id), // Return a default ProductModel
    );

    if (productToDelete.id != null) {
      // Delete the product from Hive database
      productDB.delete(id);

      // Remove the product from product.value list
      product.value.removeWhere((product) => product.id == id);

      // Notify any listeners of the change
      product.notifyListeners();
    }
  }
}
