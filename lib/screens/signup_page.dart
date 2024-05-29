// ignore_for_file: unnecessary_null_comparison, unused_import, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_week8/database/datamodel.dart';
import 'package:project_week8/functions/db_functions.dart';
import 'package:project_week8/screens/Login_Screen.dart';
import 'package:project_week8/structurecodes/signuptextfield.dart';
import 'package:project_week8/widgets/custom_text_form_field.dart';

class ScreenLogout extends StatefulWidget {
  const ScreenLogout({Key? key}) : super(key: key);

  @override
  State<ScreenLogout> createState() => _ScreenLogoutState();
}

class _ScreenLogoutState extends State<ScreenLogout> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 247, 250),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              buildHeader(context),
              const SizedBox(height: 30),
              buildForm(),
              const SizedBox(height: 30),
              buildSignUpButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {

    return SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenLogin()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 70),
          const Text(
            'Welcome ',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: nameController,
              hintText: 'Username',
              labelText: 'Username',
              validator: validateUsername,
              onSuffixIconPressed: () {},
                onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 30),
            CustomTextFormField(
              controller: emailController,
              hintText: 'Email',
              labelText: 'Email',
              validator: validateEmail,
              onSuffixIconPressed: () {},
                onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 30),
            CustomTextFormField(
              controller: passwordController,
              hintText: 'Password',
              labelText: 'Password',
              obscureText: true,
              isPasswordVisible: isPasswordVisible,
              validator: validatePassword,
              onSuffixIconPressed: togglePasswordVisibility,
                onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 30),
            CustomTextFormField(
              controller: confirmPasswordController,
              hintText: 'Confirm password',
              labelText: 'Confirm password',
              obscureText: true,
              isPasswordVisible: isPasswordVisible,
              validator: validateConfirmPassword,
              onSuffixIconPressed: togglePasswordVisibility,
                onChanged: (value) => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignUpButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          checkSignup(context);
        } else {
          print('Data is empty or invalid');
        }
      },
      child: const Text('Sign Up', style: TextStyle(fontSize: 20)),
    );
  }

  void checkSignup(BuildContext context) async {
    final signupModel = SignUpModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    if (await addData(signupModel, context)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenLogin()));
    } else {
      showErrorMessage(context, 'Invalid username, email, or password');
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: const EdgeInsets.all(16),
      content: Text(message),
    ));
  }

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username must contain only letters, numbers, or underscores';
    }
    if (value.length < 3 || value.length > 20) {
      return 'Username must be between 3 and 20 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!isValidEmail(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 7) {
      return 'Password must contain at least 7 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }}
