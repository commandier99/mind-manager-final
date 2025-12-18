import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.blue,
      // The hamburger icon (drawer icon) is automatically added by Flutter
      // when a Drawer is present in the Scaffold and the AppBar is part of it.
      // You don't need to explicitly add an IconButton here for the drawer.
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}