import 'package:flutter/material.dart';
import 'package:netflix/features/profile/presentation/pages/widgets/change_password_body.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const ChangePasswordBody(),
    );
  }
}
