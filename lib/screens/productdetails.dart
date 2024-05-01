// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:project_week8/database/datamodel.dart';
// import 'package:project_week8/functions/db_functions.dart'; // Import image_picker package

// class MyProducts extends StatefulWidget {
//   const MyProducts({Key? key}) : super(key: key);

//   @override
//   State<MyProducts> createState() => _MyProductsState();
// }

// class _MyProductsState extends State<MyProducts> {
//   final _formKey = GlobalKey<FormState>(); // Form key for validation

//   // Text editing controllers for each TextFormField
//   final TextEditingController _productNameController = TextEditingController();
//   final TextEditingController _authorNameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _volumeController = TextEditingController();

//   File? _pickedImage;

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _pickedImage = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   void dispose() {
//     // Clean up controllers
//     _productNameController.dispose();
//     _authorNameController.dispose();
//     _priceController.dispose();
//     _volumeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           autovalidateMode: AutovalidateMode.always,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 60),
//               GestureDetector(
//                 onTap:
//                     _pickImage, // Call the _pickImage function when the container is tapped
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   color: Colors.grey[200],
//                   child: _pickedImage != null
//                       ? Image.file(
//                           _pickedImage!,
//                           fit: BoxFit.cover,
//                         )
//                       : const Center(
//                           child: Text('Pick an image from the gallery'),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: _productNameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Product Name',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter product name';
//                     }
//                     return null;
//                   },
//                   onChanged: (_) => _formKey.currentState!.validate(),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: _authorNameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Author name',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter author name';
//                     }
//                     return null;
//                   },
//                   onChanged: (_) => _formKey.currentState!.validate(),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: _priceController,
//                   decoration: const InputDecoration(
//                     labelText: 'Price',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter price';
//                     }
//                     return null;
//                   },
//                   onChanged: (_) => _formKey.currentState!.validate(),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: _volumeController,
//                   decoration: const InputDecoration(
//                     labelText: 'Volume',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter volume';
//                     }

//                     return null;
//                   },
//                   onChanged: (_) => _formKey.currentState!.validate(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Validate the form before saving
//                   if (_formKey.currentState!.validate()) {
//                     ProductModel productmodel = ProductModel(
//                         productname: _productNameController.text,
//                         authorname: _authorNameController.text,
//                         price: _priceController.text,
//                         volume: _volumeController.text);
//                     addProduct(productmodel);
//                   }
//                 },
//                 child: const Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
