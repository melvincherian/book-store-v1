// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel category;

  const EditCategory({Key? key, required this.category}) : super(key: key);

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  File? image;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.category.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              SizedBox(
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(
                            context, image); // Pass back the edited image
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 40),
                    const Text(
                      'Edit Category',
                      style: TextStyle(
                          fontSize: 38,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      image: image != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(image!),
                            )
                          : null,
                    ),
                    child: image == null
                        ? Image.asset(
                            'assets/camera.png',
                            fit: BoxFit.cover,
                            
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                 
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Category name',
                    labelText: 'Category name'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (image != null) {
                    // Construct a new CategoryModel object with updated data
                    CategoryModel updatedCategory = CategoryModel(
                      id: widget.category.id, // Use the existing ID
                      name: nameController.text, // Updated name
                      image: image!.path, // Updated image path
                    );

                    // Update the category in the database
                    await updateCategory(updatedCategory);

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        'Category updated successfully',
                        style: TextStyle(color: Colors.black),
                      ),
                    ));
                       
                    // Pass back the updated image path to the previous screen
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, image!.path);
                  } else {
                    // Show a snackbar if no image is selected
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        'No image selected!',
                        style: TextStyle(color: Colors.black),
                      ),
                    ));
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'No image selected !',
          style: TextStyle(color: Colors.black),
        ),
      ));
    }
  }
}
