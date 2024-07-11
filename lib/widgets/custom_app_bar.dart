import 'package:flutter/material.dart';

import '../brandings/branding.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    this.actions,
    super.key,
  });

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: Navigator.of(context).canPop()
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Hero(
                tag: Branding.of(context).logo,
                child: Image.asset(Branding.of(context).logo),
              ),
            ),
      leadingWidth: 88,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
