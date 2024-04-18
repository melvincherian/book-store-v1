import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/screens/profile.dart';

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              SizedBox(
                height: 50,
                child: Row(
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
                    const SizedBox(width: 55),
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontSize: 38,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 125),
                  GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: CircleAvatar(
                          backgroundImage:
                              image != null ? FileImage(image!) : null,
                          radius: 80,
                          child: image == null
                              ? Image.asset(
                                  'assets/images/edit-profile-vector-icon.jpg',
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
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: usernameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Username',
                              hintText: 'Username'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Email',
                              hintText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: passController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Password',
                              hintText: 'Password'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: confirmController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Confirm Password',
                              hintText: 'Confirm Password'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm password  required';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      checkProfile(context);
                    }
                    saveImage();
                  },
                  child: const Text('Save')),
              IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'Profile updated successfully',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.save))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    // ignore: non_constant_identifier_names
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        image = File(PickedFile.path);
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'No image selected !',
            style: TextStyle(color: Colors.black),
          )));
    }
  }

  Future<void> saveImage() async {
    if (image != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Image saved successfully',
            style: TextStyle(color: Colors.black),
          )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'No image selected !',
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
