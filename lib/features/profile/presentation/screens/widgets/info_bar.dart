import 'package:flutter/material.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/styles.dart';

class InfoBar extends StatelessWidget {
  final int likesCount;
  final int photosCount;

  const InfoBar({
    super.key,
    required this.likesCount,
    required this.photosCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Column(
            children: [
              Text(
                "$photosCount",
                style: Styles.textStyle20.copyWith(color: KMainColor),
              ),
              Opacity(
                opacity: 0.6,
                child: Text("Photos", style: Styles.textStyle14),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          width: 80,
          child: Column(
            children: [
              Text(
                "$likesCount",
                style: Styles.textStyle20.copyWith(color: KMainColor),
              ),
              Opacity(
                opacity: 0.6,
                child: Text("Likes", style: Styles.textStyle14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
