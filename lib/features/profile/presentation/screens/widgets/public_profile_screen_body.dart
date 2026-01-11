import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/presentation/cubit/external_user_cubit/external_user_cubit.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/background_image.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/go_back_buton_highlighted.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/info_bar.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/profile_image.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/user_memories.dart';

class PublicProfileScreenBody extends StatelessWidget {
  final UserModel user;
  const PublicProfileScreenBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ExternalUserCubit, ExternalUserState>(
      builder: (context, state) {
        if (state is ExternalUserLoaded) {
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

                      ProfileImage(
                        height: height,
                        width: width,
                        user: user,
                        isPublic: true,
                      ),
                    ],
                  ),
                  Text(
                    state.userData.username,
                    style: Styles.textStyle30.copyWith(
                      color: KMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // InfoBar(
                  //   likesCount: state.likesCount,
                  //   photosCount: state.memoriesCount,
                  // ),
                  UserMemories(totalMemories: state.memoriesCount),
                ],
              ),
            ),
          );
        } else if (state is ExternalUserLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ExternalUserError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text("No user data"));
        }
      },
    );
  }
}
