import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';
import 'package:project_week8/screens/categories.dart';

class NewCategory extends StatefulWidget {
  final CategoryModel? category;

  const NewCategory({Key? key, this.category}) : super(key: key);

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  late TextEditingController nameController;
  File? image;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.category?.name ?? '');
    image = widget.category != null ? File(widget.category!.image) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 240, 240),
        title: const Text(
          'Add Category',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyCategories(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              GestureDetector(
                onTap: getImage,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 160),
                    CircleAvatar(
                      backgroundImage: image != null ? FileImage(image!) : null,
                      radius: 50,
                      child: image == null
                          ? Image.asset(
                              'assets/images/addimage.jpg',
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Category Name',
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  saveImage();
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> saveImage() async {
    if (image != null) {
      if (nameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Please enter a category name',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'category added successfully',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );

      final CategoryModel categoryModel = CategoryModel(
        name: nameController.text,
        image: image!.path,
        id: widget.category?.id, // Use existing category id if editing
      );
      final int id = await saveData(categoryModel);
      categoryModel.id = id;
      // saveData(categoryModel);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Please select an image!',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }
}
