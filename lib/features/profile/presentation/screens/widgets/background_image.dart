import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/core/utils/functions/cache_fix.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/presentation/cubit/user_images_cubit/user_images_cubit.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, required this.user, required this.height});

  final UserModel user;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(cacheFix(user.backgroundImage)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
