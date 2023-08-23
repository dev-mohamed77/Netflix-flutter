import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/components/button_custom.dart';
import 'package:netflix/core/components/loading_page.dart';
import 'package:netflix/core/components/text_form_field_custom.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/config/app_assets_config.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/auth/presentation/manager/providers.dart';
import 'package:netflix/features/auth/presentation/pages/widgets/forget_password_image.dart';

import '../../../../../../core/manager/dailog/dialog_custom.dart';

class ForgetPasswordBody extends ConsumerStatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  ConsumerState<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends ConsumerState<ForgetPasswordBody> {
  late TextEditingController controller;

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    controller = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgetPasswordProvider = ref.watch(forgetPasswordUseCaseProvider);

    ref.listen(
      forgetPasswordUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "The reset code has been sent successfully",
              color: AppColorsManager.green,
            ).then((value) {
              context.goNamed(
                Routes.verifyPassResetCode,
                queryParameters: {"email": controller.text},
              );
              controller.text = "";
            });
          },
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
              ),
            );
            controller.text = "";
          },
        );
      },
    );

    return forgetPasswordProvider.isLoading
        ? const LoadingPage(title: "Loading ...")
        : Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const VerticalSpacer(30),
                const ForgetPasswordImage(
                  assetName: AppAssetsConfig.forgetPassword,
                ),
                const VerticalSpacer(30),
                TextFormFieldCustom(
                  hintText: "Email",
                  controller: controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                  prefixIcon: Icons.email,
                  hintColor: AppColorsManager.black,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ButtonCustom(
                    title: const Text(
                      "Continue",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColorsManager.white,
                      ),
                    ),
                    blurButton: 3,
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(forgetPasswordUseCaseProvider.notifier)
                            .execute(
                              email: controller.text,
                            );
                      }
                    },
                  ),
                ),
                const VerticalSpacer(20),
              ],
            ),
          );
  }
}
