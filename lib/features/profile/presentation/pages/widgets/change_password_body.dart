import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/extensions/color_extensions.dart';
import 'package:netflix/core/manager/dailog/dialog_custom.dart';

import '../../../../../core/components/button_custom.dart';
import '../../../../../core/components/text_form_field_custom.dart';
import '../../../../../core/components/vertical_spacer.dart';
import '../../../../../core/manager/color/colors_manager.dart';
import '../../manager/providers.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  late GlobalKey<FormState> _form;

  late TextEditingController currentPasswordController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    _form = GlobalKey<FormState>();
    passwordController = TextEditingController();
    currentPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    currentPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          const VerticalSpacer(35),
          TextFormFieldCustom(
            prefixIcon: Icons.lock,
            hintText: "Current Password",
            hintColor: context.scrimColor,
            controller: currentPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter New Password";
              }
              return null;
            },
          ),
          const VerticalSpacer(20),
          TextFormFieldCustom(
            prefixIcon: Icons.lock,
            hintText: "New Password",
            hintColor: context.scrimColor,
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter New Password";
              } else if (value.length < 8) {
                return "Password must be atleast 8 characters long";
              }
              return null;
            },
          ),
          const VerticalSpacer(20),
          TextFormFieldCustom(
            prefixIcon: Icons.lock,
            hintText: "Confirm Password",
            hintColor: context.scrimColor,
            controller: confirmPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Re-Enter New Password";
              } else if (value.length < 8) {
                return "Password must be atleast 8 characters long";
              } else if (value != passwordController.text) {
                return "Password must be same as above";
              }
              return null;
            },
          ),
          const Spacer(),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, _) {
              final changePass = ref.watch(changePasswordUseCaseProvider);

              _changePasswordListen(ref);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ButtonCustom(
                  title: changePass.isLoading
                      ? const CircularProgressIndicator(
                          color: AppColorsManager.white,
                          strokeWidth: 2,
                        )
                      : const Text(
                          "Change Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColorsManager.white,
                          ),
                        ),
                  onClick: () {
                    if (_form.currentState!.validate()) {
                      ref.read(changePasswordUseCaseProvider.notifier).execute(
                            password: passwordController.text,
                            currentPassword: currentPasswordController.text,
                          );
                    }
                  },
                ),
              );
            },
          ),
          const VerticalSpacer(20),
        ],
      ),
    );
  }

  _changePasswordListen(WidgetRef ref) {
    ref.listen(
      changePasswordUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(
              message: "Password changed successfully",
              color: AppColorsManager.green,
            );
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(
              message: error.toString(),
              color: Colors.red,
            );
          },
        );
      },
    );
  }
}
