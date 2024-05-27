// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, library_private_types_in_public_api, file_names, unused_import

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';
import 'package:project_week8/structurecodes/editbooktext.dart';
import 'package:hive/hive.dart';

class EditBook extends StatefulWidget {
  final ProductModel? product;

  const EditBook({Key? key, this.product}) : super(key: key);

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBook> {
  File? _image;
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _selectCategory = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    
    super.initState();
    if (widget.product != null) {
      _authorController.text = widget.product!.authorname;
      _priceController.text = widget.product!.price;
      _volumeController.text = widget.product!.volume;
      _bookNameController.text = widget.product!.bookname;
      _countController.text = widget.product!.count;
      _selectCategory.text = widget.product!.categoryName;
      // Load image if it exists
      // _image = widget.product!.imageFile; // Assuming you have a way to convert your image path to a File
    }
  }

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
        title: const Text(
          'Edit Book',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
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
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.image,
                          size: 100,
                          color: Colors.grey,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _authorController,
                label: 'Author Name',
                validator: (value) =>
                    _validateField(value, 'Please enter author name'),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _priceController,
                label: 'Price',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    _validateField(value, 'Please enter price'),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _volumeController,
                label: 'Volume',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    _validateField(value, 'Please enter volume'),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _bookNameController,
                label: 'Book Name',
                validator: (value) =>
                    _validateField(value, 'Please enter book name'),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _countController,
                label: 'Product Count',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    _validateField(value, 'Please enter count'),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _selectCategory,
                label: 'Select Category',
                readOnly: true,
                validator: (value) =>
                    _validateField(value, 'Please enter the category name'),
                onTap: _showCategoryDialog,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _validateAndSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Update',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateField(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['Fiction', 'Action'].map((categoryName) {
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
  }

  void _validateAndSave() async {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = ProductModel(
        bookname: _bookNameController.text,
        authorname: _authorController.text,
        price: _priceController.text,
        volume: _volumeController.text,
        count: _countController.text,
        categoryName: _selectCategory.text,
        id: widget.product?.id,
      );

      try {
        await updateProduct(updatedProduct);
        // Optionally show a success message before popping the context
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
              content: Text(
            'Book updated successfully',
            style: TextStyle(color: Colors.black),
          )),
        );

        Navigator.pop(context, {
          'image': _image,
          'author': _authorController.text,
          'price': _priceController.text,
          'volume': _volumeController.text,
          'bookName': _bookNameController.text,
          'count': _countController.text,
          'category': _selectCategory.text,
        });
      } catch (e) {
        print("Error updating product: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating product: $e')),
        );
      }
    }
  }
}

