import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/presentation/cubit/user_photos_cubit/user_photos_cubit.dart';
import 'package:mapory/features/profile/presentation/screens/widgets/photos_grid.dart';

class UserMemories extends StatelessWidget {
  final int totalPhotos;
  const UserMemories({super.key, required this.totalPhotos});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<UserPhotosCubit, UserPhotosState>(
          builder: (context, state) {
            if (state is UserPhotosLoaded) {
              List<PhotoModel> photos = BlocProvider.of<UserPhotosCubit>(
                context,
              ).photos;
              return PhotosGrid(totalPhotos: totalPhotos, photos: photos);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
