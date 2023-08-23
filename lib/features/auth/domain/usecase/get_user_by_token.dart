// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/core/providers/token_local_provider.dart';
import 'package:netflix/core/providers/user_local_provider.dart';

import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/auth/domain/repositories/auth_repository.dart';

class GetUserByTokenUseCase extends StateNotifier<AsyncValue<UserEntity?>> {
  final AuthRepository repo;
  final Ref ref;
  GetUserByTokenUseCase({
    required this.repo,
    required this.ref,
  }) : super(const AsyncValue.data(null));

  Future<void> execute() async {
    final token = ref.watch(tokenLocalProvider);

    final result = await repo.getUserByToken(token: token.toString());

    result.when(
      success: (data) {
        state = AsyncValue.data(data);
        ref.watch(userLocalProvider.notifier).setUser(data);
      },
      failure: (errorHandle) => state = AsyncValue.error(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.current,
      ),
    );
  }
}
