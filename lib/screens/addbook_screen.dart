// ignore_for_file: unused_import, library_private_types_in_public_api, avoid_print, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';
import 'package:project_week8/structurecodes/addbooktextfield.dart';
import 'package:project_week8/widgets/custom_text_form_field.dart'; // Import the custom widget

class AddBookPage extends StatefulWidget {
  final List<String> addedCategoryNames;

  const AddBookPage({Key? key, required this.addedCategoryNames}) : super(key: key);

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
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
      appBar: AppBar(
        title: const Text('Add Book',
        style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                    color: Colors.grey[200],
                  ),
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(_image!, fit: BoxFit.cover),
                        )
                      : const Icon(Icons.image, size: 100, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _authorController,
                hintText: 'Author Name',
                validatorMessage: 'Please enter author name',
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _priceController,
                hintText: 'Price',
                keyboardType: TextInputType.number,
                validatorMessage: 'Please enter price',
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _volumeController,
                hintText: 'Volume',
                keyboardType: TextInputType.number,
                validatorMessage: 'Please enter volume',
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _bookNameController,
                hintText: 'Book Name',
                validatorMessage: 'Please enter book name',
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _countController,
                hintText: 'Product Count',
                keyboardType: TextInputType.number,
                validatorMessage: 'Please enter count',
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _selectCategory,
                decoration: InputDecoration(
                  labelText: 'Select Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the category name';
                  }
                  return null;
                },
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select Category'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: widget.addedCategoryNames.map((categoryName) {
                            return ListTile(
                              title: Text(categoryName),
                              onTap: () {
                                setState(() {
                                  _selectCategory.text = categoryName;
                                });
                                Navigator.pop(context);
                              },
                            );
                          }).toList(),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newProduct = ProductModel(
                      bookname: _bookNameController.text,
                      authorname: _authorController.text,
                      price: _priceController.text,
                      volume: _volumeController.text,
                      count: _countController.text,
                      categoryName: _selectCategory.text,
                      id: null,
                    );

                    try {
                      await addProduct(newProduct);

                      Navigator.pop(context, {
                        'image': _image,
                        'author': _authorController.text,
                        'price': _priceController.text,
                        'volume': _volumeController.text,
                        'bookName': _bookNameController.text,
                        'count': _countController.text,
                        'categoryName': _selectCategory.text, // Ensure consistent key
                      });
                    } catch (e) {
                      print("Error saving product: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error saving product: $e')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Save', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
