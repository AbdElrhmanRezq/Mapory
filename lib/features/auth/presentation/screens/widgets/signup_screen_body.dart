import 'package:flutter/material.dart';
import 'package:mapory/core/utils/assets.dart';
import 'package:mapory/core/widgets/custom_app_button.dart';
import 'package:mapory/features/auth/presentation/screens/widgets/text_field.dart';

GlobalKey<FormState> _key = GlobalKey<FormState>();

class SignupScreenBody extends StatelessWidget {
  const SignupScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AssetsData.person1, width: 250, height: 250),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                CustomTextFormField(
                  hintText: "Email Address",
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                Divider(color: Colors.black),
                CustomTextFormField(
                  hintText: "Password",
                  icon: Icons.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                AppButton(text: "Login"),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
