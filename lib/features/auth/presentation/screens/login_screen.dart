import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/core/widgets/simple_app_bar.dart';

import 'package:mapory/features/auth/presentation/screens/widgets/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: SimpleAppBar(), body: LoginScreenBody());
  }
}
