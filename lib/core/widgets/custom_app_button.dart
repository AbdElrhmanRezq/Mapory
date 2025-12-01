import 'package:flutter/material.dart';
import 'package:mapory/consts.dart';
import 'package:mapory/core/utils/styles.dart';

class CustomAppButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  const CustomAppButton({
    super.key,
    this.width = double.infinity,
    this.height = 50,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () {},
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
