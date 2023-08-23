import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/auth/domain/entities/signin_entity.dart';
import 'package:netflix/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase extends StateNotifier<AsyncValue<SignInEntity?>> {
  ResetPasswordUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null));

  final AuthRepository repo;

  Future<void> execute({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final result = await repo.resetPassword(email: email, password: password);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (err) => AsyncValue.error(
        ErrorHandle.getErrorMessage(err),
        StackTrace.current,
      ),
    );
  }
}
