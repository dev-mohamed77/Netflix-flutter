import 'package:flutter/material.dart';

import '../manager/color/colors_manager.dart';

class OutLineButtonIconCustom extends StatelessWidget {
  const OutLineButtonIconCustom({
    super.key,
    required this.title,
    required this.icon,
    required this.onClick,
    Color? colorSide,
    Color? textColor,
    Color? iconColor,
  })  : _colorSide = colorSide ?? AppColorsManager.white,
        _textColor = textColor ?? AppColorsManager.white,
        _iconColor = iconColor ?? AppColorsManager.white;

  final String title;
  final IconData icon;
  final void Function() onClick;
  final Color _colorSide;
  final Color _textColor;
  final Color _iconColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(width: 1.2, color: _colorSide),
      ),
      onPressed: onClick,
      icon: Icon(
        icon,
        color: _iconColor,
      ),
      label: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          color: _textColor,
        ),
      ),
    );
  }
}
