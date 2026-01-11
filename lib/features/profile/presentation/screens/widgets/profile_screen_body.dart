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
import 'package:mapory/features/profile/presentation/screens/widgets/go_back_buton_highlighted.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/info_bar.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/profile_image.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/user_name.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/user_memories.dart';

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
                            height: height * 0.07,
                          ),
                        ],
                      ),
                      Positioned(
                        left: 10,
                        top: 30,
                        child: GoBackButtonHighlighted(),
                      ),
                      Positioned(
                        right: 10,
                        top: 30,
                        child: EditBackgroundButton(),
                      ),
                      ProfileImage(height: height, width: width, user: user),
                    ],
                  ),
                  UserName(
                    state: state,
                    onTapFunction: () async {
                      changeUserName(state.userData.username);
                    },
                  ),
                  SizedBox(height: 10),
                  // InfoBar(
                  //   likesCount: state.likesCount,
                  //   photosCount: state.memoriesCount,
                  // ),
                  //SizedBox(height: 10),
                  UserMemories(totalMemories: state.memoriesCount),
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

class EditBackgroundButton extends StatelessWidget {
  const EditBackgroundButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await BlocProvider.of<UserImagesCubit>(
          context,
        ).uploadUserImage('background_image');
        await BlocProvider.of<UserDataCubit>(context).fetchUserData();
      },
      icon: Icon(Icons.edit, color: KMainColor),
    );
  }
}
