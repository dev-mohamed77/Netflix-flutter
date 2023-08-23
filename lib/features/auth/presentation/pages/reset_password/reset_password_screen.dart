// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:netflix/features/auth/presentation/pages/reset_password/widgets/reset_password_body.dart';
import 'package:netflix/features/auth/presentation/pages/widgets/forget_password_app_bar.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ForgetPasswordAppBar(
        title: "Create New Password",
      ),
      body: ResetPasswordBody(
        email: email,
      ),
    );
  }
}
