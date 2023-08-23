// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/providers/token_local_provider.dart';
import 'package:netflix/core/service/local_service/providers.dart';
import 'package:netflix/core/service/local_service/shared_keys.dart';

abstract class AuthLocalDataSource {
  Object? getToken();

  Future<bool> addToken(String token);
}

class AuthLocalDataSourceImp extends AuthLocalDataSource {
  final Ref ref;
  AuthLocalDataSourceImp(
    this.ref,
  );
  @override
  Future<bool> addToken(String token) async {
    ref.read(tokenLocalProvider.notifier).setToken(token);
    final shared = await ref.read(sharedServiceProvider);
    return shared.setData(
      key: SharedPrefKeys.signInKey,
      value: token,
    );
  }

  @override
  Object? getToken() async {
    final shared = await ref.read(sharedServiceProvider);
    return shared.getData(SharedPrefKeys.signInKey);
  }
}

final authLocalDataSourceProvider = Provider((ref) {
  return AuthLocalDataSourceImp(ref);
});
