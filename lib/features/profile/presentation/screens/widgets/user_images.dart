import 'package:flutter/material.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/styles.dart';

class UserImages extends StatelessWidget {
  const UserImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Photos", style: Styles.textStyle16),
              SizedBox(width: 8),
              CircleAvatar(
                maxRadius: 12,
                backgroundColor: KMainColor,
                child: Text(
                  "16",
                  style: Styles.textStyle14.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
