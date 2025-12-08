import 'package:flutter/material.dart';
import 'package:mapory/core/utils/functions/reformate_date.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';

class PhotoDetails extends StatelessWidget {
  const PhotoDetails({super.key, required this.photo});

  final PhotoModel photo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsElement(
            heading: "Caption",
            content: photo.caption ?? "Artist has added no caption!",
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
