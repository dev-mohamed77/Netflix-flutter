import 'package:flutter/material.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/extensions/color_extensions.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: context.accentColor,
          ),
          const VerticalSpacer(20),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
