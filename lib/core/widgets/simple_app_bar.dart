import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapory/core/utils/styles.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<IconButton>? actions;
  final String? title;
  const SimpleAppBar({super.key, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios_new),
      ),
      title: title != null
          ? Text(
              title!,
              style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
            )
          : null,
      centerTitle: true,
      scrolledUnderElevation: 0,
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
