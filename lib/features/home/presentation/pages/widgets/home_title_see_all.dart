import 'package:flutter/material.dart';
import 'package:netflix/core/extensions/color_extensions.dart';

class HomeTitleSeeAll extends StatelessWidget {
  const HomeTitleSeeAll({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: context.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("See all"),
          ),
        ],
      ),
    );
  }
}
