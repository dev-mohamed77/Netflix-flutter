import 'package:flutter/material.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';

class ElevatedButtonIconCustom extends StatelessWidget {
  const ElevatedButtonIconCustom({
    super.key,
    required this.title,
    required this.icon,
    required this.onClick,
  });

  final String title;
  final IconData icon;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        icon,
        color: AppColorsManager.white,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.accentColor,
      ),
      onPressed: onClick,
      label: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: AppColorsManager.white,
        ),
      ),
    );
  }
}
