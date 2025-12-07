import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/data/repo/user_repo_impl.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/go_back_buton_highlighted.dart';

class PhotoScreenBody extends StatelessWidget {
  final PhotoModel photo;
  const PhotoScreenBody({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final UserRepoImpl userRepo = getIt<UserRepoImpl>();

    return FutureBuilder(
      future: userRepo.getUserData(id: photo.userId),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (asyncSnapshot.hasError) {
          return Center(child: Text("Failure"));
        } else if (asyncSnapshot.hasData) {
          return asyncSnapshot.data!.fold(
            (failure) => Center(child: Text("Failure")),
            (userData) => Column(
              children: [
                Stack(
                  children: [
                    Hero(tag: photo.id, child: Image.network(photo.imageUrl)),
                    Positioned(
                      left: 10,
                      top: 30,
                      child: GoBackButtonHighlighted(),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text("No data"));
        }
      },
    );
  }
}
