import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenLocal extends StateNotifier<String?> {
  TokenLocal() : super(null);

  setToken(String token) {
    state = token;
  }

  setNull() {
    state = null;
  }
}

final tokenLocalProvider = StateNotifierProvider<TokenLocal, String?>(
  (ref) => TokenLocal(),
);
