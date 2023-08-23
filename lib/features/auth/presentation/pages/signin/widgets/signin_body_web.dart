import 'package:flutter/material.dart';
import 'package:netflix/core/components/button_custom.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';

import '../../../../../../core/components/background_image_custom.dart';
import '../../../../../../core/components/text_form_field_custom.dart';

class SignInBodyWeb extends StatelessWidget {
  SignInBodyWeb({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const BackgroundImageCustom(),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Container(
          height: 550,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 25,
                    color: context.secondaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 350,
                child: TextFormFieldCustom(
                  hintText: "Email",
                  hintColor: context.secondaryColor,
                  controller: emailController,
                  validator: (val) {
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 350,
                child: TextFormFieldCustom(
                  hintText: "Password",
                  hintColor: context.secondaryColor,
                  controller: passwordController,
                  validator: (val) {
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: ButtonCustom(
                    title: Text(
                      "Sign in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.secondaryColor,
                      ),
                    ),
                    onClick: () {},
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Row(
                    children: [
                      const Text(
                        "New to Netflix?",
                        style: TextStyle(
                          color: AppColorsManager.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Sign up now",
                          style: TextStyle(
                            color: context.secondaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
