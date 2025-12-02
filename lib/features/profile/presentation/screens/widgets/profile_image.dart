import 'package:flutter/material.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.height,
    required this.width,
    required this.user,
  });

  final double height;
  final double width;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: height * 0.23,
      left: width * 0.333,
      child: Container(
        decoration: BoxDecoration(
          color: KMainBackground,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 59,
            backgroundImage: NetworkImage(user.profileImage),
          ),
        ),
      ),
    );
  }
}
