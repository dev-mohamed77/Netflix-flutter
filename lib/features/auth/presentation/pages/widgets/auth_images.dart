import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthImages extends StatelessWidget {
  const AuthImages({
    super.key,
    required this.path,
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: SvgPicture.asset(
        path,
        height: 130,
      ),
    );
  }
}
