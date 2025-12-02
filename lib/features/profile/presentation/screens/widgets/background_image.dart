import 'package:flutter/material.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, required this.user, required this.height});

  final UserModel user;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      user.backgroundImage,
      height: height * 0.31,
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
}
