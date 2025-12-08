import 'package:flutter/material.dart';
import 'package:mapory/core/utils/assets.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/profile/data/models/user_model.dart';

class ArtistBar extends StatelessWidget {
  final UserModel userData;
  const ArtistBar({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,

      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsData.artistBackGround),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(backgroundImage: NetworkImage(userData.profileImage)),
          SizedBox(width: 10),
          Text(
            userData.username,
            style: Styles.textStyle16.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
