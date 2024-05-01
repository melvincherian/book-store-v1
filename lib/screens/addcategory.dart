import 'package:flutter/material.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';
import 'package:project_week8/screens/addbook.dart';
import 'package:project_week8/screens/bookdetail.dart';
// Import the details page

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> savedDetailsList = []; // Change to a list

  @override
  void initState() {
    saveProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 204, 204),
        title: const Text(
          'Books',
          style: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: savedDetailsList.isEmpty // Check if savedDetailsList is empty
          ? const Center(
              child: Text(
                'No books added yet',
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search books...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                ),
                // Display saved details here
                for (final savedDetails in savedDetailsList) ...[
                  GestureDetector(
                    onTap: () => _navigateToDetailsPage(savedDetails),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display the first image if available
                          if (savedDetails['image'] != null)
                            Expanded(
                              child: Image.file(
                                savedDetails['image'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          // Display other details
                          const SizedBox(width: 8.0), // Add spacing between images
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Author: ${savedDetails['author']}'),
                                Text('Book Name: ${savedDetails['bookName']}'),
                                Text('Price: ${savedDetails['price']}'),
                                Text('Volume: ${savedDetails['volume']}'),
                                Text('Count: ${savedDetails['count']}'),
                                // Add more details as needed
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to AddBookPage and wait for result
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookPage()),
          );

          // Update savedDetails with the result if available
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              savedDetailsList.add(result);
            });
            // Add the product to the database
            await addProduct(ProductModel(
              bookname: result['bookName'],
              authorname: result['author'],
              price: result['price'],
              volume: result['volume'],
              count: result['count'],
            ));
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // Function to navigate to the details page
  void _navigateToDetailsPage(Map<String, dynamic> details) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage(details: details)),
    );
  }
}
