import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/app_router.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/background_image.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/profile_image.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/user_images.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is UserDataLoaded) {
          final user = state.userData;
          return Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        BackgroundImage(user: user, height: height),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: () {
                              GoRouter.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: () {
                              // GoRouter.of(
                              //   context,
                              // ).push(AppRouter.kEditProfileRoute);

                              //Change Background Image
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.08),
                    GestureDetector(
                      onTap: () {
                        //Change User name
                      },
                      child: Text(
                        state.userData.username,
                        style: Styles.textStyle20.copyWith(
                          color: KMainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    UserImages(),
                  ],
                ),
              ),
              ProfileImage(height: height, width: width, user: user),
            ],
          );
        } else if (state is UserDataLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserDataError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text("No user data"));
        }
      },
    );
  }
}
