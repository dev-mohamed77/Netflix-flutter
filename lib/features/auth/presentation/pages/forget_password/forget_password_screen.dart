import 'package:flutter/material.dart';
import 'package:netflix/features/auth/presentation/pages/forget_password/widgets/forget_password_body.dart';

import '../widgets/forget_password_app_bar.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ForgetPasswordAppBar(
        title: "Forget Password",
      ),
      body: ForgetPasswordBody(),
    );
  }
}
