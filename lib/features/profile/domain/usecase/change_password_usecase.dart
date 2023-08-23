import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/profile/domain/repository/profile_repository.dart';

class ChangePasswordUseCase extends StateNotifier<AsyncValue<UserEntity?>> {
  final ProfileRepository repo;

  ChangePasswordUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null));

  Future<void> execute({
    required String password,
    required String currentPassword,
  }) async {
    state = const AsyncLoading();

    final result = await repo.changePassword(
      password: password,
      currentPassword: currentPassword,
    );
    state = result.when(
      success: (data) => AsyncValue.data(data.user),
      failure: (errorHandle) => AsyncError(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.empty,
      ),
    );
  }
}
