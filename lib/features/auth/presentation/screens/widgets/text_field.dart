import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.validator,
    required this.controller,
  });

  final String hintText;
  final IconData icon;
  final String? Function(String? p1)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: Icon(icon),
        border: InputBorder.none,
        errorStyle: TextStyle(color: Colors.red, fontSize: 14),
      ),
      validator: validator,
      controller: controller,
      obscureText: hintText == 'Password',
    );
  }
}
