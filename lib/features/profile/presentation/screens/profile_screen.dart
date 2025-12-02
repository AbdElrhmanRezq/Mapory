import 'package:flutter/material.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/profile_screen_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ProfileScreenBody(height: height, width: width),
    );
  }
}
