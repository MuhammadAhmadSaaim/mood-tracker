import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final Function(bool)? onTogglePasswordVisibility; // Optional function to toggle password visibility
  final String? Function(String?)? validator; // Custom validation function
  final TextInputType keyboardType; // Keyboard type for text input

  AuthTextField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false,
    this.onTogglePasswordVisibility,
    this.validator,
    this.keyboardType = TextInputType.text, // Default keyboard type is text
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.black),
      keyboardType: keyboardType, // Set the keyboard type
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.black54),
        suffixIcon: null,
        labelStyle: TextStyle(color: Colors.black),
        iconColor: Colors.grey,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pink.shade900),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
    );
  }
}
