import 'package:flutter/material.dart';
import 'package:mapory/core/widgets/simple_app_bar.dart';

import 'package:mapory/features/auth/presentation/screens/widgets/signup_screen_body.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: SimpleAppBar(), body: SignupScreenBody());
  }
}
