import 'package:flutter/material.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/public_profile_screen_body.dart';

class PublicProfileScreen extends StatelessWidget {
  final UserModel user;
  const PublicProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PublicProfileScreenBody(user: user));
  }
}
