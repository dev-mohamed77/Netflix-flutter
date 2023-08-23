// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/components/loading_page.dart';
import 'package:netflix/core/components/text_button_custom.dart';
import 'package:netflix/core/config/app_assets_config.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/core/manager/dailog/dialog_custom.dart';
import 'package:netflix/core/providers/user_local_provider.dart';
import 'package:netflix/features/auth/presentation/manager/providers.dart';
import 'package:netflix/features/auth/presentation/pages/widgets/auth_form_section.dart';
import 'package:netflix/features/auth/presentation/pages/widgets/auth_images.dart';
import 'package:netflix/features/auth/presentation/pages/widgets/auth_title.dart';
import '../../../../../../core/manager/router/routes.dart';
import '../../widgets/auth_or_section.dart';
import '../../widgets/auth_social_button.dart';

class SignInBodyMobile extends ConsumerWidget {
  SignInBodyMobile({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInProvider = ref.watch(signInUseCaseProvider);

    ref.listen(signInUseCaseProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        data: (data) async {
          // I used user local because the data is empty And that's because mounted in signin use case
          final user = ref.watch(userLocalProvider);

          DialogCustom.showToast(
            message: "Logged in successfully",
            color: AppColorsManager.green,
          ).then((value) {
            final membershipStartDate = user?.membershipStartDate;
            final membershipEndDate = user?.membershipEndDate;

            if ((membershipStartDate == "" || membershipStartDate == null) ||
                (membershipEndDate == "" || membershipEndDate == null)) {
              context.goNamed(Routes.plans);
            } else {
              // compare DateTime.now() with membershipEndDate
              final isEndMember = DateTime.now().isBefore(
                DateTime.parse(membershipEndDate),
              );

              if (isEndMember) {
                context.go(Routes.home);
              } else {
                context.goNamed(Routes.plans);
              }
            }
          });
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ),
          );
        },
      );
    });

    return signInProvider.isLoading
        ? const LoadingPage(title: "Sign in")
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const AuthImages(
                  path: AppAssetsConfig.netflixLogo,
                ),
                const AuthTitle(title: "Login to your Account"),
                const SizedBox(
                  height: 40,
                ),
                AuthFormSection(
                  textButton: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColorsManager.white,
                    ),
                  ),
                  onClickButton: () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(signInUseCaseProvider.notifier).execute(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    }
                  },
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
                  appleOnClick: () {
                    context.pushNamed(Routes.plans);
                  },
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
                      "Don't have an account?",
                    ),
                    TextButtonCustom(
                      title: "Sign up",
                      onClick: () {
                        context.push(Routes.signUp);
                      },
                    ),
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
