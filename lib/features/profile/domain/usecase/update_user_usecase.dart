import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/profile/domain/repository/profile_repository.dart';

class UpdateUserUseCase extends StateNotifier<AsyncValue<UserEntity?>> {
  final ProfileRepository repo;

  UpdateUserUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null));

  Future<void> execute({
    String? fullName,
    String? phone,
    String? gender,
  }) async {
    state = const AsyncLoading();

    final result = await repo.updateUser(
      fullName: fullName,
      phone: phone,
      gender: gender,
    );

    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (errorHandle) => AsyncError(
        ErrorHandle.getErrorMessage(errorHandle),
        StackTrace.empty,
      ),
    );
  }
}
