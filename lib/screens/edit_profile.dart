// ignore_for_file: unused_import, non_constant_identifier_names, use_build_context_synchronously, file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/screens/profile_page.dart';
import 'package:project_week8/structurecodes/editprofiletextfield.dart';
import 'package:project_week8/widgets/custom_text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<SignUpModel> userData = [];

  File? image;

  @override
  void initState() {
    getAlldata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           const   SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScreenProfile()));
                      },
                      icon: const Icon(Icons.arrow_back)),
               const   SizedBox(width: 70),
                const  Text(
                    'Edit Profile',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
          const    SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: CircleAvatar(
                          backgroundImage:
                              image != null ? FileImage(image!) : null,
                          child: image == null
                              ? Image.asset(
                                  'assets/images/edit-profile-vector-icon.jpg',
                                  width: 90,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  
                                )
                              : null))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: usernameController,
                          labelText: 'Username',
                          hintText: 'Username',
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                        ),
                   const     SizedBox(height: 20),
                        CustomTextField(
                          controller: emailController,
                          labelText: 'Email',
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                     const   SizedBox(height: 20),
                        CustomTextField(
                          controller: passController,
                          labelText: 'Password',
                          hintText: 'Password',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                    const    SizedBox(height: 20),
                        CustomTextField(
                          controller: confirmController,
                          labelText: 'Confirm Password',
                          hintText: 'Confirm Password',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm password is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
              ),
           const   SizedBox(height: 40),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      checkProfile(context);
                    }
                    saveImage();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                  child: const Text(
                    'Update Profile',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        image = File(PickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'No image selected!',
            style: TextStyle(color: Colors.black),
          )));
    }
  }

  Future<void> saveImage() async {
    if (image != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Profile updated successfully',
            style: TextStyle(color: Colors.black),
          )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'No image selected!',
            style: TextStyle(color: Colors.black),
          )));
    }
  }

  bool isvalidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void checkProfile(BuildContext context) async {
    final username = usernameController.text;
    final email = emailController.text;
    final password = passController.text;
    final confirmpass = confirmController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmpass.isEmpty) {
      return;
    } else if (!isvalidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(16),
        content: Text('Invalid email format'),
      ));
    }
  }

  Future<void> getAlldata() async {
    final bookDB = await Hive.openBox<SignUpModel>('login_db');
    setState(() {
      userData.clear(); // Clear existing user data
      userData.addAll(bookDB.values); // Add all user data from the database
    });

    // Set retrieved data to the corresponding text controllers
    if (userData.isNotEmpty) {
      setState(() {
        usernameController.text = userData[0].name;
        emailController.text = userData[0].email;
        passController.text = userData[0].password;
        confirmController.text = userData[0]
            .password; // Assuming confirmController should have the same value as passController initially
      });
    }
  }
}
