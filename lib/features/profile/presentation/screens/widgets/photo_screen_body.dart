import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/assets.dart';
import 'package:mapory/core/utils/functions/reformate_date.dart';
import 'package:mapory/core/utils/service_locator.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/repo/user_repo_impl.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/artist_bar.dart';
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
            (userData) => ListView(
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
                ArtistBar(userData: userData),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailsElement(
                        heading: "Caption",
                        content:
                            photo.caption ?? "Artist has added no caption!",
                      ),
                      SizedBox(height: 16),
                      DetailsElement(
                        heading: "Date",
                        content: reformatDate(photo.createdAt),
                      ),

                      /////////////////////////////////////
                      ///// Here will be the map location
                      ///
                      ///
                      ///////////////////////////////////
                    ],
                  ),
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

class DetailsElement extends StatelessWidget {
  final String heading;
  final String content;
  const DetailsElement({
    super.key,
    required this.heading,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Text(content, style: Styles.textStyle18),
      ],
    );
  }
}
