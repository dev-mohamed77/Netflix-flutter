import 'package:flutter/material.dart';
import 'package:netflix/core/extensions/color_extensions.dart';

class WelcomeSocialButton extends StatelessWidget {
  const WelcomeSocialButton({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.onClick,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 50,
      height: 45,
      child: OutlinedButton.icon(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade100, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onClick,
        icon: Icon(
          icon,
          color: iconColor,
        ),
        label: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: context.secondaryColor,
          ),
        ),
      ),
    );
  }
}
