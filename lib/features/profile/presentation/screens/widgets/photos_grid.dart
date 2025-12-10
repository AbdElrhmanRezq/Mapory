import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/core/utils/app_router.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/presentation/cubit/user_photos_cubit/user_photos_cubit.dart';

class PhotosGrid extends StatelessWidget {
  const PhotosGrid({
    super.key,
    required this.totalPhotos,
    required this.photos,
  });

  final int totalPhotos;
  final List<PhotoModel> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: totalPhotos > photos.length
          ? photos.length + 1
          : photos.length,
      itemBuilder: (context, index) {
        ////////////////////////////////////
        ////  The next checks are for
        ////  adding the load more
        ////  photos button
        ////////////////////////////////////
        if (totalPhotos > photos.length) {
          if (index != (photos.length)) {
            return Image.network(photos[index].imageUrl, fit: BoxFit.cover);
          } else {
            return IconButton(
              onPressed: () {
                BlocProvider.of<UserPhotosCubit>(context).fetchUserPhotos();
              },
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Load More", style: Styles.textStyle16),
                  Text(
                    "+${totalPhotos - photos.length}",
                    style: Styles.textStyle16,
                  ),
                ],
              ),
            );
          }
        } else {
          return GestureDetector(
            onTap: () {
              GoRouter.of(
                context,
              ).push(AppRouter.kPhotoRoute, extra: photos[index]);
            },
            child: Hero(
              tag: photos[index].id,
              child: Image.network(photos[index].imageUrl, fit: BoxFit.cover),
            ),
          );
        }
      },
    );
  }
}
