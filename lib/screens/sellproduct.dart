import 'package:flutter/material.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';

class SellProduct extends StatefulWidget {
  const SellProduct({Key? key}) : super(key: key);

  @override
  State<SellProduct> createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

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
                    fontSize: 28.0,
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
                    hintText: 'Name'),
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
                    hintText: 'Phone Number'),
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
                keyboardType: TextInputType.phone, // Set keyboard type to phone
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: productController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Product',
                    hintText: 'Product'),
                onChanged: (_) {
                  if (_autovalidateMode == AutovalidateMode.always) {
                    _formKey.currentState!.validate();
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please choose a product';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: discountController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Discount',
                    hintText: 'Discount'),
                onChanged: (_) {
                  if (_autovalidateMode == AutovalidateMode.always) {
                    _formKey.currentState!.validate();
                  }
                },
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Price',
                    hintText: 'Price'),
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
                keyboardType:const TextInputType.numberWithOptions(decimal: true), // Set keyboard type to number
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                  if (_formKey.currentState!.validate()) {
                    final sellProduct = SellProductModel(
                      name: nameController.text,
                      phonenumber: phoneController.text,
                      product: productController.text,
                      discount: discountController.text,
                      price: priceController.text,
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
}
