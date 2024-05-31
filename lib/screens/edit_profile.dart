// ignore_for_file: unused_import, file_names, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/screens/profile_page.dart';
import 'package:project_week8/widgets/custom_text_field.dart';

import '../structurecodes/editprofiletextfield.dart';

class EditProfile extends StatefulWidget {
  final Function(File?) updateProfileImage;

  const EditProfile({super.key, required this.updateProfileImage});

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
      appBar: AppBar(
        title: const Text('Edit Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: image != null ? FileImage(image!) : null,
                  child: image == null
                      ? Icon(Icons.person, size: 60, color: Colors.grey[400])
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: usernameController,
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!isvalidEmail(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: passController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: confirmController,
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm password is required';
                        } else if (value != passController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          checkProfile(context);
                          saveImage();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Update Profile',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ],
                ),
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content:
              Text('No image selected!', style: TextStyle(color: Colors.white)),
        ),
      );
    }
  }

  Future<void> saveImage() async {
    if (image != null) {
      widget.updateProfileImage(image); // Update the profile image
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Profile updated successfully',
              style: TextStyle(color: Colors.white)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content:
              Text('No image selected!', style: TextStyle(color: Colors.white)),
        ),
      );
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Invalid email format',
              style: TextStyle(color: Colors.white)),
        ),
      );
    }
  }

  Future<void> getAlldata() async {
    final bookDB = await Hive.openBox<SignUpModel>('login_db');
    setState(() {
      userData.clear();
      userData.addAll(bookDB.values);
    });

    if (userData.isNotEmpty) {
      setState(() {
        usernameController.text = userData[0].name;
        emailController.text = userData[0].email;
        passController.text = userData[0].password;
        confirmController.text = userData[0].password;
      });
    }
  }
}
