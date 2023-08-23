// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  LocalAuth._();

  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> _canAuthentication() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate({
    required String title,
    final bool? biometricOnly,
    final bool? sensitiveTransaction,
    final bool? stickyAuth,
    final bool? useErrorDialogs,
  }) async {
    try {
      if (!await _canAuthentication()) return false;

      return await _auth.authenticate(
        options: AuthenticationOptions(
          biometricOnly: biometricOnly ?? false,
          sensitiveTransaction: sensitiveTransaction ?? false,
          stickyAuth: stickyAuth ?? false,
          useErrorDialogs: useErrorDialogs ?? false,
        ),
        authMessages: const [],
        localizedReason: title,
      );
    } catch (err) {
      debugPrint("err $err");

      return false;
    }
  }
}
