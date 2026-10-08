import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const new({required this.onLogout, super.key});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      actions: [
        IconButton(onPressed: onLogout, icon: const Icon(Icons.logout)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
