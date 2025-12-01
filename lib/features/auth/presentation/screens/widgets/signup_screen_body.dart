import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/assets.dart';
import 'package:mapory/core/utils/functions/empty_validator.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/core/widgets/custom_app_button.dart';
import 'package:mapory/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mapory/features/auth/presentation/screens/widgets/text_field.dart';

GlobalKey<FormState> _key = GlobalKey<FormState>();

class SignupScreenBody extends StatelessWidget {
  const SignupScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's Start",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  hintText: "Email Address",
                  icon: Icons.email,
                  controller: emailController,
                  validator: emptyValidator("email"),
                ),
                Divider(color: Colors.black),
                CustomTextFormField(
                  hintText: "Username",
                  icon: Icons.person,
                  controller: usernameController,

                  validator: emptyValidator("username"),
                ),

                Divider(color: Colors.black),
                CustomTextFormField(
                  hintText: "Password",
                  icon: Icons.lock,
                  controller: passwordController,
                  validator: emptyValidator("password"),
                ),
                SizedBox(height: 20),
                BlocConsumer<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: KMainColor),
                      );
                    } else if (state is AuthSignedUp) {
                      return Center(
                        child: Text(
                          "Signup Successful! Please check your email to verify your account then login.",
                          style: Styles.textStyle16,
                        ),
                      );
                    } else {
                      return AppButton(
                        text: "SignUp",
                        onPressed: () {
                          if (_key.currentState?.validate() ?? false) {
                            context.read<AuthCubit>().signup(
                              emailController.text,
                              usernameController.text,
                              passwordController.text,
                            );
                          }
                        },
                      );
                    }
                  },
                  listener: (context, state) {
                    if (state is AuthSignedUp) {
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
