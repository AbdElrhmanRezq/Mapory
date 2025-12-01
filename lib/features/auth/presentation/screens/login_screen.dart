import 'package:flutter/material.dart';
import 'package:mapory/core/utils/assets.dart';
import 'package:mapory/core/utils/styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Image.asset(AssetsData.person1, width: 150, height: 150)],
        ),
      ),
    );
  }
}
