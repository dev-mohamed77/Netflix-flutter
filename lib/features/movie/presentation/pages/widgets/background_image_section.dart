import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';

class BackgroundImageSection extends StatelessWidget {
  const BackgroundImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * 0.35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
