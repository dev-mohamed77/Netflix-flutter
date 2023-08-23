import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/auth/domain/entities/signin_entity.dart';
import 'package:netflix/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase extends StateNotifier<AsyncValue<SignInEntity?>> {
  SignInUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null));

  final AuthRepository repo;

  Future<void> execute({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final result = await repo.signIn(email: email, password: password);

    if (!mounted) {
      return;
    }

    result.when(
      success: (data) => state = AsyncValue.data(data),
      failure: (err) => state = AsyncValue.error(
        ErrorHandle.getErrorMessage(err),
        StackTrace.current,
      ),
    );
  }
}
