import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix/features/auth/presentation/pages/signup/widgets/signup_body_mobile.dart';
import '../../../../../core/components/responsive.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.grey[80],
        ),
      ),
      body: Responsive(
        mobile: SignUpBodyMobile(),
        web: const SizedBox(),
        webSmall: const SizedBox(),
      ),
    );
  }
}
