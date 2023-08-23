import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/components/button_custom.dart';
import 'package:netflix/core/components/loading_page.dart';
import 'package:netflix/core/components/text_form_field_custom.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/core/providers/user_local_provider.dart';
import 'package:netflix/features/auth/presentation/manager/providers.dart';
import 'package:netflix/features/auth/presentation/pages/widgets/auth_remember_me.dart';

import '../../../../../../core/components/vertical_spacer.dart';
import '../../../../../../core/config/app_assets_config.dart';
import '../../../../../../core/manager/dailog/dialog_custom.dart';
import '../../../../data/data_source/auth_local_data_source.dart';
import '../../widgets/forget_password_image.dart';

class ResetPasswordBody extends ConsumerStatefulWidget {
  final String email;
  const ResetPasswordBody({super.key, required this.email});

  @override
  ConsumerState<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends ConsumerState<ResetPasswordBody> {
  late TextEditingController password;
  late TextEditingController confirmPassword;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    password = TextEditingController();
    confirmPassword = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resetPassword = ref.watch(resetPasswordUseCaseProvider);

    ref.listen(
      resetPasswordUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
                    message: "Password changed successfully",
                    color: Colors.green)
                .then(
              (value) {
                ref.watch(authLocalDataSourceProvider).addToken(data!.token);
                ref.read(userLocalProvider.notifier).setUser(data.user);
                context.go(Routes.home);
              },
            );
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
                message: error.toString(), color: Colors.red);
          },
        );
      },
    );

    return resetPassword.isLoading
        ? const LoadingPage(title: "Loading ..")
        : SingleChildScrollView(
            child: Column(
              children: [
                const VerticalSpacer(30),
                const ForgetPasswordImage(
                  assetName: AppAssetsConfig.forgetPassword,
                ),
                const VerticalSpacer(40),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Create Your New Password",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const VerticalSpacer(30),
                      TextFormFieldCustom(
                        hintText: "New Password",
                        controller: password,
                        prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "New Password required";
                          }

                          return null;
                        },
                        hintColor: AppColorsManager.black,
                      ),
                      const VerticalSpacer(15),
                      TextFormFieldCustom(
                        hintText: "Confirm Password",
                        controller: confirmPassword,
                        prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Confirm Password required";
                          }

                          return null;
                        },
                        hintColor: AppColorsManager.black,
                      ),
                      const VerticalSpacer(15),
                      const AuthRememberMe(),
                      const VerticalSpacer(60),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: ButtonCustom(
                          title: const Text(
                            "Confirm",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColorsManager.white,
                            ),
                          ),
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .read(resetPasswordUseCaseProvider.notifier)
                                  .execute(
                                    email: widget.email,
                                    password: password.text,
                                  );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
