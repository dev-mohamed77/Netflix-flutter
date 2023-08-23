import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/components/button_custom.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/core/manager/router/routes.dart';

import '../../../../../core/components/text_button_custom.dart';
import '../../../../../core/components/text_form_field_custom.dart';
import 'auth_remember_me.dart';

class AuthFormSection extends StatelessWidget {
  const AuthFormSection({
    super.key,
    required this.textButton,
    this.onClickButton,
    bool? isSignIn,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  }) : _isSignIn = isSignIn ?? true;

  final Widget textButton;
  final void Function()? onClickButton;
  final bool? _isSignIn;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormFieldCustom(
            prefixIcon: Icons.email,
            hintText: "Email",
            controller: emailController,
            validator: (val) {
              if (val!.isEmpty) {
                return "Email required";
              }
              return null;
            },
            hintColor: AppColorsManager.black,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormFieldCustom(
            suffixIcon: Icons.visibility,
            prefixIcon: Icons.lock,
            hintText: "Password",
            controller: passwordController,
            suffixOnClick: () {},
            obscureText: true,
            validator: (val) {
              if (val!.isEmpty) {
                return "Email required";
              }
              return null;
            },
            hintColor: AppColorsManager.black,
          ),
          const SizedBox(
            height: 10,
          ),
          const AuthRememberMe(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ButtonCustom(
              title: textButton,
              onClick: onClickButton,
            ),
          ),
          _isSignIn!
              ? const SizedBox(
                  height: 5,
                )
              : const SizedBox(
                  height: 20,
                ),
          if (_isSignIn!)
            TextButtonCustom(
              title: "Forgot the password?",
              onClick: () {
                context.push(Routes.forgetPassword);
              },
            ),
        ],
      ),
    );
  }
}
