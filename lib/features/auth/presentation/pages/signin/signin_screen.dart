import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix/core/components/responsive.dart';
import 'package:netflix/core/utility/platform_info.dart';
import 'package:netflix/features/auth/presentation/pages/signin/widgets/app_bar_web_custom.dart';
import 'package:netflix/features/auth/presentation/pages/signin/widgets/signin_body_small.dart';
import 'package:netflix/features/auth/presentation/pages/signin/widgets/signin_body_web.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PlatFormInfo.isWeb() || PlatFormInfo.isDesktopOs()
          ? const AppBarWebCustom()
          : AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.grey[80],
              ),
            ),
      body: Responsive(
        mobile: SignInBodyMobile(),
        web: SignInBodyWeb(),
        webSmall: const SizedBox(),
      ),
    );
  }
}
