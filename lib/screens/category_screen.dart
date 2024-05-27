// ignore_for_file: use_build_context_synchronously, sort_child_properties_last, non_constant_identifier_names, unnecessary_import, avoid_types_as_parameter_names, file_names

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';
import 'package:project_week8/screens/Editcategory_Screen.dart';
import 'package:project_week8/screens/Favourites_Screen.dart';
import 'package:project_week8/screens/Home_Screen.dart';
import 'package:project_week8/screens/New_Category.dart';
import 'package:project_week8/screens/Profile_Page.dart';
import 'package:project_week8/screens/add_category.dart';

class MyCategories extends StatefulWidget {
  const MyCategories({Key? key}) : super(key: key);

  @override
  State<MyCategories> createState() => _MyCategoriesState();
}

class _MyCategoriesState extends State<MyCategories> {
  int _selectedIndex = 1;
  List<CategoryModel> categoryData = [];
  List<CategoryModel> filteredCategories = [];
  bool isDataFetched = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    categoryData = await saveData();
    setState(() {
      filteredCategories = categoryData; // Initially, show all categories
      isDataFetched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 235, 240),
      appBar: AppBar(
        title: const Text(
          'Category',
          style: TextStyle(
            fontSize: 38,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenHome(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 241, 215, 215),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: SizedBox(
              height: 90,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    filteredCategories = categoryData
                        .where((category) => category.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: isDataFetched
                ? filteredCategories.isEmpty
                    ? const Center(
                        child: Text(
                          'No categories found',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : GridView.builder(
                        itemCount: filteredCategories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final CategoryModel category =
                              filteredCategories[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddCategory(
                                    addedCategoryNames:
                                        categoryData
                                            .map((Category) => category.name)
                                            .toList(),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (category.image.isNotEmpty &&
                                      File(category.image).existsSync())
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                        File(category.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                     
                                      color: const Color.fromARGB(255, 17, 17, 17),
                                      child: Text(
                                        category.name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: PopupMenuButton(
                                      color: Colors.white,
                                      icon:const Icon(Icons.more_vert,color: Colors.white,),
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          
                                          value: 'edit',
                                          child: Text('Edit'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Text('Delete'),
                                        ),
                                      ],
                                      onSelected: (value) async {
                                        if (value == 'edit') {
                                          await _navigateToEditCategory(
                                              context, category);
                                        } else if (value == 'delete') {
                                          _confirmDelete(context, category);
                                        }
                                      },
                                    ),
                                    
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenHome(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyCategories(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenProfile(),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenFavourite(),
                ),
              );
              break;
            default:
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favorites',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewCategory(),
            ),
          ).then((_) {
            // Refresh data after adding a new category
            fetchData();
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<List<CategoryModel>> saveData() async {
    final saveDB = await Hive.openBox<CategoryModel>('save data');
    final List<CategoryModel> data = saveDB.values.toList();
    saveDB.close();
    return data;
  }

  Future<void> deleteCategory(int id) async {
    final CategoryModel categoryToDelete =
        categoryData.firstWhere((element) => element.id == id);
    final File imageFile = File(categoryToDelete.image);

    if (await imageFile.exists()) {
      await imageFile.delete();
    }

    await deleteData(categoryToDelete.id!);

    setState(() {
      categoryData.removeWhere((element) => element.id == id);
    });
  }

  Future<void> _confirmDelete(
      BuildContext context, CategoryModel category) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this category?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await deleteCategory(category.id!);
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _navigateToEditCategory(
      BuildContext context, CategoryModel category) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCategory(category: category),
      ),
    );
    // Refresh data after editing a category
    fetchData();
  }
}
