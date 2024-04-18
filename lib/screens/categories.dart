import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';
import 'package:project_week8/screens/editcategory.dart';
import 'package:project_week8/screens/home.dart';
import 'package:project_week8/screens/profile.dart';
import 'package:project_week8/screens/addcategory.dart';


class MyCategories extends StatefulWidget {
  const MyCategories({Key? key}) : super(key: key);

  @override
  State<MyCategories> createState() => _MyCategoriesState();
}

class _MyCategoriesState extends State<MyCategories> {
  List<CategoryModel> categoryData = [];
  bool isDataFetched = false;

  @override
  void initState() {
    super.initState();
    if (!isDataFetched) {
      fetchData();
      isDataFetched = true;
    }
  }

  Future<void> fetchData() async {
    
    categoryData = await saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 235, 240),
      appBar: AppBar(
        title: const Text(
          'Categories',
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
       const   SizedBox(height: 10),
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (value) {
                  // Handle search query
                },
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: category,
              builder: (context, value, _) {
                categoryData = value.reversed.toList();
                if (categoryData.isEmpty) {
                  return const Center(
                    child: Text(
                      'No categories added yet',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                } else {
                  return GridView.builder(
                    itemCount: categoryData.length,
                    itemBuilder: (context, index) {
                      final CategoryModel category = categoryData[index];
                      if (File(category.image).existsSync()) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddCategory(),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 160,
                                height: 160,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(category.image)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  style:const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 1,
                                right: 1,
                                child: IconButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm Deletion"),
                                          content: const Text(
                                              "Are you sure you want to delete this category?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await deleteCategory(
                                                    category.id!);
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 50,
                                right: 1,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditCategory(category: category)));
                                    
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          width: 160,
                          height: 160,
                          margin: const EdgeInsets.all(8),
                        );
                      }
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenHome(),
                  ),
                );
              },
              icon: const Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyCategories(),
                  ),
                );
              },
              icon: const Icon(Icons.add_box),
              color: Colors.blue,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenProfile(),
                  ),
                );
              },
              icon: const Icon(Icons.person),
              color: Colors.blue,
            ),
            label: 'Profile',
          ),
        ],
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
}
