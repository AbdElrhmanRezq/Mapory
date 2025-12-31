import 'package:flutter/material.dart';
import 'package:mapory/consts.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: KMainColor);
  }
}
