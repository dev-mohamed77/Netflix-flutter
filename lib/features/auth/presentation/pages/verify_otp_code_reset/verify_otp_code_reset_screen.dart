import 'package:flutter/material.dart';
import 'package:netflix/features/auth/presentation/pages/verify_otp_code_reset/widgets/verify_pass_reset_code_body.dart';

import '../widgets/forget_password_app_bar.dart';

class VerifyOtpCodeResetScreen extends StatelessWidget {
  const VerifyOtpCodeResetScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ForgetPasswordAppBar(
        title: "Forget Password",
      ),
      body: VerifyOtpCodeResetBody(email: email),
    );
  }
}
