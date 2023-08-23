import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesLoadingShimmer extends StatelessWidget {
  const CategoriesLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.white,
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              return FilterChip(
                label: Text("Categories $index"),
                onSelected: (value) {},
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 7,
              );
            },
          ),
        ));
  }
}
