import 'package:flutter/material.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';
import 'package:mapory/features/profile/data/repo/user_photos_repo_impl.dart';

class LikesBar extends StatelessWidget {
  const LikesBar({super.key, required this.userRepo, required this.photo});

  final UserPhotosRepoImpl userRepo;
  final PhotoModel photo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userRepo.getPhotosLikes(photoId: photo.id),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Text(
            "////////////////",
            style: Styles.textStyle14.copyWith(color: Colors.grey),
          );
        } else if (asyncSnapshot.hasError) {
          print(asyncSnapshot.error);
          return Center(child: Text("Failure"));
        } else if (asyncSnapshot.hasData) {
          List<UserModel> likes = asyncSnapshot.data ?? [];
          return SizedBox(
            height: 25,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              children: [
                likes.length > 0
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(likes[0].profileImage),
                      )
                    : Text("0 Likes"),
                likes.length > 1
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(likes[1].profileImage),
                      )
                    : SizedBox(),
                likes.length > 2
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(likes[2].profileImage),
                      )
                    : SizedBox(),
                likes.length > 0
                    ? Text(likes[0].username, style: Styles.textStyle16)
                    : SizedBox(),
                likes.length > 1
                    ? Text(likes[1].username, style: Styles.textStyle16)
                    : SizedBox(),
                likes.length > 3
                    ? Text("and ${likes.length - 3} other people liked.")
                    : SizedBox(),
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
