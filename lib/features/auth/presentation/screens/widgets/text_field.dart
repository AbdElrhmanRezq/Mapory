import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.validator,
  });

  final String hintText;
  final IconData icon;
  final String? Function(String? p1)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: Icon(icon),
        border: InputBorder.none,
      ),
      validator: validator,
    );
  }
}
