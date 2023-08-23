import 'package:flutter/material.dart';

class AppBarWebCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWebCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      primary: false,
      titleSpacing: 30,
      flexibleSpace: GestureDetector(
        onTap: () {},
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: const Text(
            "NetFlix",
            style: TextStyle(
              color: Colors.red,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
