import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/app_router.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:mapory/features/profile/presentation/cubit/user_images_cubit/user_images_cubit.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/background_image.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/info_bar.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/profile_image.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/user_photos.dart';

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
    TextEditingController _usernameController = TextEditingController();

    void changeUserName(String oldName) async {
      _usernameController.text = oldName;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Change Username"),
          content: TextField(
            controller: _usernameController,
            decoration: InputDecoration(hintText: "Enter new username"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await BlocProvider.of<UserDataCubit>(
                  context,
                ).changeUserName(_usernameController.text);
                Navigator.of(context).pop();
              },
              child: Text("Submit"),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is UserDataLoaded) {
          UserModel user = state.userData;
          return Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          BackgroundImage(user: user, height: height),
                          Container(
                            color: KMainBackground,
                            height: height * 0.1,
                          ),
                        ],
                      ),
                      Positioned(
                        left: 10,
                        top: 30,
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(181, 181, 181, 0.3),
                          child: IconButton(
                            onPressed: () {
                              GoRouter.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: KMainColor,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 30,
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(181, 181, 181, 0.3),
                          child: IconButton(
                            onPressed: () async {
                              await BlocProvider.of<UserImagesCubit>(
                                context,
                              ).uploadUserImage('background_image');
                              await BlocProvider.of<UserDataCubit>(
                                context,
                              ).fetchUserData();
                            },
                            icon: Icon(Icons.edit, color: KMainColor),
                          ),
                        ),
                      ),
                      ProfileImage(height: height, width: width, user: user),
                    ],
                  ),
                  //SizedBox(height: height * 0.095),
                  GestureDetector(
                    onTap: () async {
                      changeUserName(state.userData.username);
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
                  InfoBar(
                    likesCount: state.likesCount,
                    photosCount: state.photosCount,
                  ),
                  SizedBox(height: 10),
                  UserPhotos(totalPhotos: state.photosCount),
                ],
              ),
            ),
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
