import 'package:flutter/material.dart';
import 'package:netflix/core/extensions/color_extensions.dart';

class AuthRememberMe extends StatelessWidget {
  const AuthRememberMe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: true,
          onChanged: (value) {},
          side: BorderSide(
            width: 2.5,
            color: context.accentColor,
          ),
          activeColor: context.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(
            "Remember me",
          ),
        ),
      ],
    );
  }
}
