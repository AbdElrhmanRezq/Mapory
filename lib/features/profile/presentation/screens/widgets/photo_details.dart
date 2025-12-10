import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mapory/core/utils/functions/reformate_date.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/home/data/models/photo_model.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';

class PhotoDetails extends StatelessWidget {
  const PhotoDetails({super.key, required this.photo, required this.user});

  final PhotoModel photo;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Add Likes bar

          //
          //
          RichText(
            text: TextSpan(
              style: Styles.textStyle18,
              children: [
                TextSpan(
                  text: "${user.username}",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(
                  text:
                      "${photo.caption}${photo.caption}${photo.caption}${photo.caption}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: Text(
              reformatDate(photo.createdAt),
              style: Styles.textStyle14.copyWith(color: Colors.grey),
            ),
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

// class DetailsElement extends StatelessWidget {
//   final String heading;
//   final String content;
//   const DetailsElement({
//     super.key,
//     required this.heading,
//     required this.content,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           heading,
//           style: Styles.textStyle14.copyWith(
//             fontWeight: FontWeight.bold,
//             color: Colors.grey,
//           ),
//         ),
//         Text(content, style: Styles.textStyle18),
//       ],
//     );
//   }
// }
