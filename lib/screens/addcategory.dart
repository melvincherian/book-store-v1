// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:project_week8/screens/editbook.dart';
import 'package:project_week8/screens/products.dart';

class SubCategoryModel {
  String image;

  SubCategoryModel({required this.image});
}

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  List<SubCategoryModel> subcategoryList = [];
  File? image;

  @override
  void initState() {
    super.initState();
    _loadSubCategories();
  }

  void _loadSubCategories() async {
    final subcategoryDir = await getApplicationDocumentsDirectory();
    final subcategoryPath = path.join(subcategoryDir.path, 'subcategories.txt');
    final subcategoryFile = File(subcategoryPath);
    if (subcategoryFile.existsSync()) {
      final List<String> lines = subcategoryFile.readAsLinesSync();
      setState(() {
        subcategoryList =
            lines.map((line) => SubCategoryModel(image: line)).toList();
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<void> _saveSubCategory() async {
    if (image != null) {
      final subcategoryDir = await getApplicationDocumentsDirectory();
      final subcategoryPath =
          path.join(subcategoryDir.path, 'subcategories.txt');
      final subcategoryFile = File(subcategoryPath);
      await subcategoryFile.writeAsString(image!.path + '\n',
          mode: FileMode.append);
      _loadSubCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 204, 204),
        title: const Text(
          'Books',
          style: TextStyle(fontSize: 35, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: subcategoryList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>ScreenProduct()));
              // Implement onTap functionality
            },
            child: Stack(
              children: [
                Container(
                  width: 160,
                  height: 160,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(subcategoryList[index].image)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 1,
                  right: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm Delete"),
                                content: const Text(
                                    "Are you sure you want to delete ?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // Delete the image file
                                      final subcategoryDir =
                                          await getApplicationDocumentsDirectory();
                                      final subcategoryPath = path.join(
                                          subcategoryDir.path,
                                          'subcategories.txt');
                                      final subcategoryFile =
                                          File(subcategoryPath);
                                      final lines =
                                          await subcategoryFile.readAsLines();
                                      final imageToDelete =
                                          File(subcategoryList[index].image);
                                      if (imageToDelete.existsSync()) {
                                        await imageToDelete.delete();
                                      }

                                      // Remove the image path from the file
                                      lines
                                          .remove(subcategoryList[index].image);
                                      await subcategoryFile
                                          .writeAsString(lines.join('\n'));

                                      // Update UI
                                      setState(() {
                                        subcategoryList.removeAt(index);
                                      });
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
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBook()));
                          // Implement edit functionality
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _pickImage();
          await _saveSubCategory();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
