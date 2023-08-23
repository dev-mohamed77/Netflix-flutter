import 'package:flutter/material.dart';

import '../config/app_assets_config.dart';

class BackgroundImageCustom extends StatelessWidget {
  const BackgroundImageCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AppAssetsConfig.netflixBackground,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
