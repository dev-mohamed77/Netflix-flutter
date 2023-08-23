import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/manager/color/colors_manager.dart';

class ForgetPasswordAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ForgetPasswordAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      backgroundColor: AppColorsManager.transparent,
      surfaceTintColor: AppColorsManager.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey[80],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
