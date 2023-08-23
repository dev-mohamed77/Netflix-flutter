import 'package:flutter_riverpod/flutter_riverpod.dart';

class EndTimerOTP extends StateNotifier<bool> {
  EndTimerOTP() : super(false);

  selectValue(bool value) {
    if (value) {
      state = true;
    } else {
      state = false;
    }
  }
}

final endTimeOtpProvider = StateNotifierProvider.autoDispose<EndTimerOTP, bool>(
  (ref) => EndTimerOTP(),
);
