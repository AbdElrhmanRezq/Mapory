import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/app_router.dart';
import 'package:mapory/core/utils/assets.dart';
import 'package:mapory/core/utils/functions/empty_validator.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/core/widgets/custom_app_button.dart';
import 'package:mapory/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mapory/features/auth/presentation/screens/widgets/text_field.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                  controller: emailController,
                  validator: emptyValidator("Email Address"),
                ),
                Divider(color: Colors.black),
                CustomTextFormField(
                  hintText: "Password",
                  icon: Icons.lock,
                  controller: passwordController,

                  validator: emptyValidator("Password"),
                ),
                SizedBox(height: 20),
                BlocConsumer<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: KMainColor),
                      );
                    } else {
                      return AppButton(
                        text: "Login",
                        onPressed: () {
                          if (_key.currentState?.validate() ?? false) {
                            context.read<AuthCubit>().login(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                      );
                    }
                  },
                  listener: (context, state) {
                    if (state is AuthSignedIn) {
                      GoRouter.of(context).push(AppRouter.kHomeRoute);
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
  }
}
