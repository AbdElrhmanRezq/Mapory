import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/styles.dart';
import 'package:mapory/features/profile/presentation/cubit/user_data_cubit/user_data_cubit.dart';

class UserName extends StatelessWidget {
  final UserDataLoaded state;
  final void Function()? onTapFunction;
  const UserName({super.key, required this.state, this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${state.userData.username} ',
            style: Styles.textStyle30.copyWith(
              color: KMainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: KMainColor,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(Icons.edit, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
