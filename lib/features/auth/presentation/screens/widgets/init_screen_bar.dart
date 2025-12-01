import 'package:flutter/material.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/styles.dart';

class InitScreenBar extends StatelessWidget {
  const InitScreenBar({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 50,
            width: width * 0.4,
            decoration: BoxDecoration(
              color: KMainColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                "Login",
                style: Styles.textStyle16.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 50,
            width: width * 0.33,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: Text(
                "SignUp",
                style: Styles.textStyle16.copyWith(color: KMainColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
