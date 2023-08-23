import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieLoadingShimmer extends StatelessWidget {
  const MovieLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      child: GridView.builder(
        itemCount: 10,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1 / 1.4,
        ),
        itemBuilder: (context, index) {
          return Container(
            height: double.infinity,
            width: MediaQuery.sizeOf(context).width / 2.7,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }
}
