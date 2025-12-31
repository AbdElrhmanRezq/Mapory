import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/core/utils/app_router.dart';
import 'package:mapory/core/utils/functions/reformate_date.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/data/repo/user_photos_repo_impl.dart';
import 'package:mapory/features/profile/data/repo/user_repo_impl.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/likes_bar.dart';

class PhotoDetails extends StatelessWidget {
  const PhotoDetails({super.key, required this.photo, required this.user});

  final PhotoModel photo;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final UserPhotosRepoImpl userRepo = getIt<UserPhotosRepoImpl>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LikesBar(userRepo: userRepo, photo: photo),
          RichText(
            text: TextSpan(
              style: Styles.textStyle18,
              children: [
                TextSpan(
                  text: "${user.username}",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      GoRouter.of(
                        context,
                      ).push(AppRouter.kPublicProfile, extra: user);
                    },
                ),
                // TextSpan(
                //   text:
                //       "${photo.caption}${photo.caption}${photo.caption}${photo.caption}",
                //   style: Theme.of(
                //     context,
                //   ).textTheme.bodyMedium!.copyWith(fontSize: 16),
                // ),
              ],
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: Text(
              reformatDate(photo.createdAt),
              style: Styles.textStyle14.copyWith(color: Colors.grey),
            ),
          ),
          /////////////////////////////////////
          ///// Here will be the map location
          ///
          ///
          ///////////////////////////////////
        ],
      ),
    );
  }
}
