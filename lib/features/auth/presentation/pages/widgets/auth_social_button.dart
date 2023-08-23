import 'package:flutter/material.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.facebookOnClick,
    required this.googleOnClick,
    required this.appleOnClick,
  });

  final void Function() facebookOnClick;
  final void Function() googleOnClick;
  final void Function() appleOnClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _socialButton(
            icon: Icons.facebook,
            iconColor: AppColorsManager.blue,
            onClick: facebookOnClick,
          ),
          _socialButton(
            icon: Icons.facebook,
            iconColor: context.accentColor,
            onClick: googleOnClick,
          ),
          _socialButton(
            icon: Icons.apple,
            iconColor: AppColorsManager.black,
            onClick: appleOnClick,
          ),
        ],
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required Color iconColor,
    required void Function() onClick,
  }) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
