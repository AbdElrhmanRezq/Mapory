import 'package:flutter/material.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/styles.dart';

class AppButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final void Function()? onPressed;
  const AppButton({
    super.key,
    this.width = double.infinity,
    this.height = 50,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: KMainColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),

        child: Text(
          text,
          style: Styles.textStyle14.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
