import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final bool isPasswordVisible;
  final Function(String) validator;
  final VoidCallback onSuffixIconPressed;
  final TextInputType keyboardType;
  final Function(String)? onChanged;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.validator,
    required this.onSuffixIconPressed,
    this.obscureText = false,
    this.isPasswordVisible = true,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText && !isPasswordVisible,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        hintText: hintText,
        labelText: labelText,
        suffixIcon: obscureText
            ? IconButton(
                onPressed: onSuffixIconPressed,
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
      validator: (value) => validator(value!),
      onChanged: onChanged,
    );
  }
}
