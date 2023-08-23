import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:netflix/core/components/button_custom.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/config/app_assets_config.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';

class ErrorCustom extends StatelessWidget {
  const ErrorCustom({super.key, required this.title, required this.onClick});

  final String title;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        const VerticalSpacer(30),
        SvgPicture.asset(
          AppAssetsConfig.errorServe,
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
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ButtonCustom(
              title: const Text(
                "Try Again",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColorsManager.white,
                ),
              ),
              onClick: onClick),
        ),
        const VerticalSpacer(35),
      ],
    );
  }
}
