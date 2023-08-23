import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/extensions/responsive_size_extensions.dart';
import '../config/app_assets_config.dart';

class AppBarCustomSection extends StatelessWidget {
  const AppBarCustomSection({
    super.key,
    required this.title,
    this.onClick,
    bool? isSearch,
  }) : _isSearch = isSearch ?? true;

  final String title;
  final void Function()? onClick;

  final bool? _isSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: context.width,
          height: context.height * 0.1,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssetsConfig.netflixLogo,
                    width: 18,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (_isSearch!)
                IconButton(
                  onPressed: onClick,
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: context.backgroundColor,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
