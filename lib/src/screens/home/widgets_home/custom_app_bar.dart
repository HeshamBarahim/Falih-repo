import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading:
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
