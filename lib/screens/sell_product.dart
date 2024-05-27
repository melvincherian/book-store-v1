// ignore_for_file: unused_import, file_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';
import 'package:project_week8/screens/sell_details.dart';
import 'package:project_week8/widgets/custom_text_form_field.dart';

import '../structurecodes/sellproductfield.dart';

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
  final TextEditingController quantityController = TextEditingController();

  List<String>? selectedProducts;

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final List<String> products = [
    'HarryPotter',
    'AtomicHabits',
    'Darkness',
    'Ice age',
    'Fist of fury',
    'End game',
  ];

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
              CustomTextFormField(
                controller: nameController,
                labelText: 'Name',
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (_) {
                  if (_autovalidateMode == AutovalidateMode.always) {
                    _formKey.currentState!.validate();
                  }
                },
              ),
              const SizedBox(height: 20.0),
              CustomTextFormField(
                controller: phoneController,
                labelText: 'Phone Number',
                hintText: 'Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid phone number (10 digits)';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                onChanged: (_) {
                  if (_autovalidateMode == AutovalidateMode.always) {
                    _formKey.currentState!.validate();
                  }
                },
              ),
              const SizedBox(height: 20.0),
              MultiSelectDialogField(
                items: products
                    .map((product) => MultiSelectItem<String>(product, product))
                    .toList(),
                title: const Text("Products"),
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                buttonIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 79, 79, 79),
                ),
                buttonText: const Text(
                  "Choose Products",
                  style: TextStyle(color: Color.fromARGB(255, 60, 60, 60)),
                ),
                onConfirm: (results) {
                  setState(() {
                    selectedProducts = results.cast<String>();
                    _updatePriceWithDiscount();
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please choose at least one product';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              CustomTextFormField(
                controller: discountController,
                labelText: 'Discount',
                hintText: 'Discount',
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      (double.tryParse(value) == null ||
                          double.parse(value) < 0 ||
                          double.parse(value) > 100)) {
                    return 'Please enter a valid discount percentage (0-100)';
                  }
                  return null;
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) {
                  if (_autovalidateMode == AutovalidateMode.always) {
                    _formKey.currentState!.validate();
                  }
                  _updatePriceWithDiscount();
                },
              ),
              const SizedBox(height: 20.0),
              CustomTextFormField(
                controller: priceController,
                labelText: 'Price',
                hintText: 'Price',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  } else if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) {
                  if (_autovalidateMode == AutovalidateMode.always) {
                    _formKey.currentState!.validate();
                  }
                },
              ),
              const SizedBox(height: 20.0),
              CustomTextFormField(
                controller: quantityController,
                labelText: 'Quantity',
                hintText: 'Quantity',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  } else if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) {
                  if (_autovalidateMode == AutovalidateMode.always) {
                    _formKey.currentState!.validate();
                  }
                },
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
                      MaterialPageRoute(
                          builder: (context) =>
                              const SellDetails(SellProductModel: null)),
                    );
                    final sellProduct = SellProductModel(
                      name: nameController.text,
                      phonenumber: phoneController.text,
                      product: selectedProducts!.join(', '),
                      discount: discountController.text,
                      price: priceController.text,
                      quantity: int.parse(quantityController.text),
                    );
                    addSellproduct(sellProduct);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  'Sell',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updatePriceWithDiscount() {
    if (selectedProducts != null && selectedProducts!.isNotEmpty) {
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
