import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase extends StateNotifier<AsyncValue<UserEntity?>> {
  SignUpUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null));

  final AuthRepository repo;

  Future<void> execute({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final result = await repo.signUp(email: email, password: password);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (err) => AsyncValue.error(
        ErrorHandle.getErrorMessage(err),
        StackTrace.current,
      ),
    );
  }
}
