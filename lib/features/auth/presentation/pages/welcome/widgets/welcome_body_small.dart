import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/components/button_custom.dart';
import 'package:netflix/core/config/app_assets_config.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/auth/presentation/pages/welcome/widgets/welcome_social_button.dart';
import 'package:netflix/features/auth/presentation/pages/widgets/auth_images.dart';

import '../../widgets/auth_or_section.dart';
import '../../widgets/auth_title.dart';

class WelcomeBodySmall extends StatelessWidget {
  const WelcomeBodySmall({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthImages(path: AppAssetsConfig.welcome),
          const AuthTitle(
            title: "Let's you in",
            fontSize: 28,
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              WelcomeSocialButton(
                icon: Icons.facebook,
                title: "Continue with Facebook",
                iconColor: Colors.blue,
                onClick: () {
                  context.pushNamed(Routes.payment);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              WelcomeSocialButton(
                icon: Icons.safety_check,
                title: "Continue with Google",
                iconColor: Colors.red,
                onClick: () {},
              ),
              const SizedBox(
                height: 15,
              ),
              WelcomeSocialButton(
                icon: Icons.apple,
                title: "Continue with apple",
                iconColor: Colors.black,
                onClick: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const AuthOrSection(title: "Or"),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ButtonCustom(
              title: const Text(
                "Sign in with password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColorsManager.white,
                ),
              ),
              onClick: () {
                context.push(Routes.signIn);
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(
                  fontSize: 13,
                  color: AppColorsManager.grey,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {
                  context.push(Routes.signUp);
                },
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: context.accentColor,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
