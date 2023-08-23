import 'package:flutter/material.dart';
import 'package:netflix/core/components/responsive.dart';
import 'package:netflix/features/auth/presentation/pages/welcome/widgets/welcome_body_small.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Responsive(
        mobile: WelcomeBodySmall(),
        web: SizedBox(),
        webSmall: SizedBox(),
      ),
    );
  }
}
