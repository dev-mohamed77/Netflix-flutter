import 'package:flutter/material.dart';

import '../../../../../core/manager/color/colors_manager.dart';

class CategoriesMovieSection extends StatelessWidget {
  const CategoriesMovieSection({super.key, required this.categories});

  final List<dynamic> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Wrap(
        spacing: 5.0,
        runSpacing: 5.0,
        children: List.generate(
          categories.length,
          (index) => RawChip(
            label: Text(
              categories[index]["name"],
              style: const TextStyle(
                color: AppColorsManager.accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            side: const BorderSide(
              color: AppColorsManager.accentColor,
              width: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}
