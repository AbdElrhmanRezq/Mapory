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
    return Container(
      decoration: BoxDecoration(color: KMainColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 60,
              width: 60,
              child: Column(
                children: [
                  Text(
                    "$photosCount",
                    style: Styles.textStyle20.copyWith(color: Colors.white),
                  ),
                  Opacity(
                    opacity: 0.6,
                    child: Text(
                      "Likes",
                      style: Styles.textStyle14.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          SizedBox(
            height: 60,
            width: 60,
            child: Column(
              children: [
                Text(
                  "$likesCount",
                  style: Styles.textStyle20.copyWith(color: Colors.white),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    "Likes",
                    style: Styles.textStyle14.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
