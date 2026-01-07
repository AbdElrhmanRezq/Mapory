import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/core/utils/app_router.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/memory_model.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/presentation/cubit/user_photos_cubit/user_photos_cubit.dart';

class PhotosGrid extends StatelessWidget {
  const PhotosGrid({
    super.key,
    required this.totalMemories,
    required this.memories,
  });

  final int totalMemories;
  final List<MemoryModel> memories;

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
      itemCount: totalMemories > memories.length
          ? memories.length + 1
          : memories.length,
      itemBuilder: (context, index) {
        ////////////////////////////////////
        ////  The next checks are for
        ////  adding the load more
        ////  photos button
        ////////////////////////////////////
        if (totalMemories > memories.length) {
          if (index != (memories.length)) {
            return Image.network(
              memories[index].photos[0].imageUrl,
              fit: BoxFit.cover,
            );
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
                    "+${totalMemories - memories.length}",
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
              ).push(AppRouter.kPhotoRoute, extra: memories[index].photos[0]);
            },
            child: Hero(
              tag: memories[index].photos[0].id,
              child: Image.network(
                memories[index].photos[0].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        }
      },
    );
  }
}
