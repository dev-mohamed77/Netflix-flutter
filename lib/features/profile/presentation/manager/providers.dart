import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/profile/data/repository/profile_repository.dart';
import 'package:netflix/features/profile/domain/usecase/change_password_usecase.dart';
import 'package:netflix/features/profile/domain/usecase/update_user_usecase.dart';

import '../../../auth/domain/entities/user_entity.dart';

final updateUserUseCaseProvider =
    StateNotifierProvider<UpdateUserUseCase, AsyncValue<UserEntity?>>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return UpdateUserUseCase(repo: repo);
});

final changePasswordUseCaseProvider =
    StateNotifierProvider<ChangePasswordUseCase, AsyncValue<UserEntity?>>(
        (ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return ChangePasswordUseCase(repo: repo);
});
