// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/service/local_service/providers.dart';
import 'package:netflix/core/service/local_service/shared_keys.dart';

abstract class ProfileLocalDataSource {
  Future<bool> addToken(String token);
}

class ProfileLocalDataSourceImp extends ProfileLocalDataSource {
  final Ref ref;
  ProfileLocalDataSourceImp(
    this.ref,
  );
  @override
  Future<bool> addToken(String token) async {
    final shared = await ref.read(sharedServiceProvider);
    return shared.setData(
      key: SharedPrefKeys.signInKey,
      value: token,
    );
  }
}

final profileLocalDataSourceProvider = Provider((ref) {
  return ProfileLocalDataSourceImp(ref);
});
