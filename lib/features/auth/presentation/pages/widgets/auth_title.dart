import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({
    super.key,
    required this.title,
    double? fontSize,
  }) : _fontSize = fontSize ?? 23;

  final String title;
  final double? _fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
