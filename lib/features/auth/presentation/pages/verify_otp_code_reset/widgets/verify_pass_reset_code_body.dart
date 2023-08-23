import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/components/button_custom.dart';
import 'package:netflix/core/components/loading_page.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/auth/presentation/manager/otp_provider.dart';
import 'package:netflix/features/auth/presentation/manager/providers.dart';
import 'package:netflix/features/auth/presentation/pages/verify_otp_code_reset/widgets/text_field_otp.dart';
import '../../../../../../core/manager/dailog/dialog_custom.dart';

class VerifyOtpCodeResetBody extends ConsumerStatefulWidget {
  const VerifyOtpCodeResetBody({super.key, required this.email});

  final String email;

  @override
  ConsumerState<VerifyOtpCodeResetBody> createState() =>
      _VerifyOtpCodeResetBodyState();
}

class _VerifyOtpCodeResetBodyState
    extends ConsumerState<VerifyOtpCodeResetBody> {
  late TextEditingController oTP1;
  late TextEditingController oTP2;
  late TextEditingController oTP3;
  late TextEditingController oTP4;
  late TextEditingController oTP5;
  late TextEditingController oTP6;

  @override
  void initState() {
    oTP1 = TextEditingController();
    oTP2 = TextEditingController();
    oTP3 = TextEditingController();
    oTP4 = TextEditingController();
    oTP5 = TextEditingController();
    oTP6 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    oTP1.dispose();
    oTP2.dispose();
    oTP3.dispose();
    oTP4.dispose();
    oTP5.dispose();
    oTP6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verifyResetCode = ref.watch(verifyPassResetCodeUseCaseProvider);

    ref.listen(
      verifyPassResetCodeUseCaseProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (data) {
            DialogCustom.showToast(message: data!, color: Colors.green).then(
              (value) {
                context.goNamed(Routes.resetPassword, queryParameters: {
                  "email": widget.email,
                });
              },
            );
          },
          error: (error, stackTrace) {
            DialogCustom.showToast(message: error.toString(), color: Colors.red)
                .then(
              (value) {
                oTP1.text = "";
                oTP2.text = "";
                oTP3.text = "";
                oTP4.text = "";
                oTP5.text = "";
                oTP6.text = "";
              },
            );
          },
        );
      },
    );

    return verifyResetCode.isLoading
        ? const LoadingPage(title: "Loading ..")
        : Column(
            children: [
              const VerticalSpacer(50),
              Text(
                "Code has been send to ${widget.email}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const VerticalSpacer(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFieldOTP(
                    controller: oTP1,
                    first: true,
                    last: false,
                  ),
                  TextFieldOTP(
                    controller: oTP2,
                    first: false,
                    last: false,
                  ),
                  TextFieldOTP(
                    controller: oTP3,
                    first: false,
                    last: false,
                  ),
                  TextFieldOTP(
                    controller: oTP4,
                    first: false,
                    last: false,
                  ),
                  TextFieldOTP(
                    controller: oTP5,
                    first: false,
                    last: false,
                  ),
                  TextFieldOTP(
                    controller: oTP6,
                    first: false,
                    last: true,
                  ),
                ],
              ),
              const VerticalSpacer(30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Resend Code in ",
                  ),
                  CountDown(),
                ],
              ),
              const Spacer(),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, _) {
                  final isEndTime = ref.watch(endTimeOtpProvider);

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ButtonCustom(
                      title: !isEndTime
                          ? const Text(
                              "Verify",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColorsManager.white,
                              ),
                            )
                          : const Text(
                              "Try again",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColorsManager.white,
                              ),
                            ),
                      blurButton: 3,
                      onClick: () {
                        if (isEndTime) {
                          ref
                              .read(forgetPasswordUseCaseProvider.notifier)
                              .execute(email: widget.email);
                        } else {
                          ref
                              .read(verifyPassResetCodeUseCaseProvider.notifier)
                              .execute(
                                resetCode:
                                    "${oTP1.text}${oTP2.text}${oTP3.text}${oTP4.text}${oTP5.text}${oTP6.text}",
                              );
                        }
                      },
                    ),
                  );
                },
              ),
              const VerticalSpacer(20),
            ],
          );
  }
}

class CountDown extends ConsumerStatefulWidget {
  const CountDown({super.key});

  @override
  ConsumerState<CountDown> createState() => _CountDownState();
}

class _CountDownState extends ConsumerState<CountDown> {
  late CountdownTimerController _controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;

  @override
  void initState() {
    _controller = CountdownTimerController(endTime: endTime);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      controller: _controller,
      endTime: endTime,
      onEnd: () {
        print("End Here");
        ref.read(endTimeOtpProvider.notifier).selectValue(true);
      },
      widgetBuilder: (context, time) {
        if (time == null) {
          return const Text("${0}");
        }
        return Text("${time.sec}");
      },
    );
  }
}
