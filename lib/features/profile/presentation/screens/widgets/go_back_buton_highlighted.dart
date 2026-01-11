import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/consts.dart';

class GoBackButtonHighlighted extends StatelessWidget {
  const GoBackButtonHighlighted({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        GoRouter.of(context).pop();
      },
      icon: Icon(Icons.arrow_back_ios_new, color: KMainColor),
    );
  }
}
