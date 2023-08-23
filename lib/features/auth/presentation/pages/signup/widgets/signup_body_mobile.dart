import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/components/loading_page.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/core/manager/dailog/dialog_custom.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/auth/presentation/manager/providers.dart';

import '../../../../../../core/components/text_button_custom.dart';
import '../../../../../../core/config/app_assets_config.dart';
import '../../widgets/auth_form_section.dart';
import '../../widgets/auth_images.dart';
import '../../widgets/auth_or_section.dart';
import '../../widgets/auth_social_button.dart';
import '../../widgets/auth_title.dart';

class SignUpBodyMobile extends ConsumerWidget {
  SignUpBodyMobile({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpProvider = ref.watch(signUpUseCaseProvider);

    ref.listen(signUpUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) {
          DialogCustom.showToast(
            message: "Sign up Successfully ${data!.email}",
            color: context.accentColor,
          ).then(
            (value) {
              context.pop();
            },
          );
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });

    return signUpProvider.isLoading
        ? const LoadingPage(title: "Sign Up")
        : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const AuthImages(
                  path: AppAssetsConfig.netflixLogo,
                ),
                const AuthTitle(title: "Create your Account"),
                const SizedBox(
                  height: 40,
                ),
                AuthFormSection(
                  textButton: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColorsManager.white,
                    ),
                  ),
                  onClickButton: () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(signUpUseCaseProvider.notifier).execute(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    }
                  },
                  isSignIn: false,
                  emailController: emailController,
                  formKey: _formKey,
                  passwordController: passwordController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const AuthOrSection(title: "Or continue with"),
                const SizedBox(
                  height: 20,
                ),
                AuthSocialButton(
                  appleOnClick: () async {},
                  facebookOnClick: () {},
                  googleOnClick: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already, have an account?",
                    ),
                    TextButtonCustom(
                      title: "Sign in",
                      onClick: () {
                        context.push(Routes.signIn);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
  }
}
