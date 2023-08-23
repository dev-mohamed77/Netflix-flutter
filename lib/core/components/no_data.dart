import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/config/app_assets_config.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';

class NoData extends StatelessWidget {
  const NoData({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        SvgPicture.asset(
          AppAssetsConfig.noData,
          width: context.width / 1.5,
          alignment: Alignment.center,
        ),
        const VerticalSpacer(25),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: context.accentColor,
          ),
        ),
        const VerticalSpacer(25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: context.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        const VerticalSpacer(25),
        const Spacer(),
      ],
    );
  }
}
