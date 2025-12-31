import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/core/widgets/custom_progress_indicator.dart';
import 'package:mapory/features/home/presentation/cubit/photos_cubit/photos_cubit.dart';

class CreateMemoryScreenBody extends StatefulWidget {
  final LatLng position;
  const CreateMemoryScreenBody({super.key, required this.position});

  @override
  State<CreateMemoryScreenBody> createState() => _CreateMemoryScreenBodyState();
}

class _CreateMemoryScreenBodyState extends State<CreateMemoryScreenBody> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          TextField(
            controller: (context).read<PhotosCubit>().captionController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Description",
              border: InputBorder.none,
            ),
          ),
          BlocBuilder<PhotosCubit, PhotosState>(
            builder: (context, state) {
              if (state is PhotosInitial) {
                return Text("Add Photos to go!", style: Styles.textStyle20);
              } else if (state is PhotosLoading) {
                return CustomProgressIndicator();
              } else if (state is PhotosError) {
                return Text(state.message, style: Styles.textStyle20);
              } else {
                List<CroppedFile> photos = (context).read<PhotosCubit>().photos;
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      return Image.file(File(photos[index]!.path));
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
