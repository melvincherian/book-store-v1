// ignore_for_file: file_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_week8/database/datamodel.dart';
import 'dart:io';
import 'package:project_week8/functions/db_functions.dart';

class EditBook extends StatefulWidget {
 
  const EditBook({Key? key}) : super(key: key);
  


  @override
  // ignore: library_private_types_in_public_api
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<EditBook> {

 
  File? _image;
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _selectCategory = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: 180,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    hintText: 'Author name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter author name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    hintText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _volumeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  hintText: 'Volume',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter volume';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _bookNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    hintText: 'Book Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter book name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _countController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    hintText: 'Product Count'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Count';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _selectCategory,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    hintText: 'Select Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the category name';
                  }
                  return null;
                },
                onTap: () {
                  // Show category names when the field is tapped
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title:  Text('Select Category'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          // children: widget.addedCategoryNames.map((categoryName) {
                          //   return ListTile(
                          //     title: Text(categoryName),
                          //     onTap: () {
                          //       setState(() {
                          //         _selectCategory.text = categoryName;
                          //       });
                          //       Navigator.pop(context); // Close the dialog
                          //     },
                          //   );
                          // }).toList(),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newproduct = ProductModel(
                      bookname: _bookNameController.text,
                      authorname: _authorController.text,
                      price: _priceController.text,
                      volume: _volumeController.text,
                      count: _countController.text,
                      categoryName: _selectCategory.text,
                      id: null,
                    );
                    await addProduct(newproduct);

                    // Save book data and image
                    Navigator.pop(context, {
                      'image': _image,
                      'author': _authorController.text,
                      'price': _priceController.text,
                      'volume': _volumeController.text,
                      'bookName': _bookNameController.text,
                      'count': _countController.text,
                      'category': _selectCategory.text,
                    });
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
