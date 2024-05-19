// ignore_for_file: file_names

import 'dart:math'; // Import dart:math for random number generation
import 'package:flutter/material.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';
import 'package:project_week8/screens/sell_details.dart';

class SellProduct extends StatefulWidget {
  const SellProduct({Key? key}) : super(key: key);

  @override
  State<SellProduct> createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String? selectedProduct;

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  List<String> products = ['Product A', 'Product B', 'Product C', 'Product D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100.0),
              const Center(
                child: Text(
                  'Sell Product',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Name',
                  hintText: 'Name',
                ),
                onChanged: (_) {
                  if (_autovalidateMode == AutovalidateMode.always) {
                    _formKey.currentState!.validate();
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Phone Number',
                  hintText: 'Phone Number',
                ),
                onChanged: (_) {
                  if (_autovalidateMode == AutovalidateMode.always) {
                    _formKey.currentState!.validate();
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid phone number (10 digits)';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedProduct,
                      onChanged: (value) {
                        setState(() {
                          selectedProduct = value;
                          _updatePriceWithDiscount();
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Choose Product',
                      ),
                      items: products.map((String product) {
                        return DropdownMenuItem<String>(
                          value: product,
                          child: Text(product),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please choose a product';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: discountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Discount',
                  hintText: 'Discount',
                ),
                onChanged: (_) {
                  if (_autovalidateMode == AutovalidateMode.always) {
                    _formKey.currentState!.validate();
                  }
                  _updatePriceWithDiscount();
                },
                validator: (value) {
                  if (value != null && value.isNotEmpty && (double.tryParse(value) == null || double.parse(value) < 0 || double.parse(value) > 100)) {
                    return 'Please enter a valid discount percentage (0-100)';
                  }
                  return null;
                },
                keyboardType:const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Price',
                  hintText: 'Price',
                ),
                onChanged: (_) {
                  if (_autovalidateMode == AutovalidateMode.always) {
                    _formKey.currentState!.validate();
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  } else if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
                keyboardType:const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SellDetails()),
                    );
                    final sellProduct = SellProductModel(
                      name: nameController.text,
                      phonenumber: phoneController.text,
                      product: selectedProduct!,
                      discount: discountController.text,
                      price: priceController.text,
                      id: null,
                    );
                    addSellproduct(sellProduct);
                  }
                },
                child: const Text('Sell'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updatePriceWithDiscount() {
    if (selectedProduct != null) {
      Random random = Random();
      double randomPrice = 50 + random.nextInt(450) + random.nextDouble();
      double discount = 0;
      if (discountController.text.isNotEmpty) {
        discount = double.parse(discountController.text);
      }
      double discountedPrice = randomPrice * (1 - discount / 100);
      priceController.text = discountedPrice.toStringAsFixed(2);
    }
  }
}
