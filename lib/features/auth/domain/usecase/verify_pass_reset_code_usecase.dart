import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/auth/domain/repositories/auth_repository.dart';

class VerifyPassResetCodeUseCase extends StateNotifier<AsyncValue<String?>> {
  VerifyPassResetCodeUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null));

  final AuthRepository repo;

  Future<void> execute({required String resetCode}) async {
    state = const AsyncLoading();

    final result = await repo.verifyPassResetCode(resetCode: resetCode);

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (err) => AsyncValue.error(
        ErrorHandle.getErrorMessage(err),
        StackTrace.current,
      ),
    );
  }
}
