import 'package:flutter/material.dart';
import 'package:netflix/core/extensions/color_extensions.dart';

class TextButtonCustom extends StatelessWidget {
  const TextButtonCustom({
    super.key,
    required this.title,
    required this.onClick,
  });

  final String title;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      child: Text(
        title,
        style: TextStyle(
          color: context.accentColor,
        ),
      ),
    );
  }
}
