import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/presentation/cubit/user_photos_cubit/user_photos_cubit.dart';

class UserPhotos extends StatelessWidget {
  const UserPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Photos", style: Styles.textStyle16),
          Divider(color: KMainColor),
          SizedBox(
            height: 300,
            child: BlocBuilder<UserPhotosCubit, UserPhotosState>(
              builder: (context, state) {
                if (state is UserPhotosLoaded) {
                  List<PhotoModel> photos = BlocProvider.of<UserPhotosCubit>(
                    context,
                  ).photos;
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          photos[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
