import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:netflix/features/auth/domain/entities/signin_entity.dart';
import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/auth/domain/usecase/forget_password_usecase.dart';
import 'package:netflix/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:netflix/features/auth/domain/usecase/signin_usecase.dart';
import 'package:netflix/features/auth/domain/usecase/verify_pass_reset_code_usecase.dart';

import '../../domain/usecase/get_user_by_token.dart';
import '../../domain/usecase/signup_usecase.dart';

final signInUseCaseProvider =
    StateNotifierProvider.autoDispose<SignInUseCase, AsyncValue<SignInEntity?>>(
        (ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return SignInUseCase(repo: authRepo);
});

final signUpUseCaseProvider =
    StateNotifierProvider<SignUpUseCase, AsyncValue<UserEntity?>>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return SignUpUseCase(repo: authRepo);
});

final forgetPasswordUseCaseProvider =
    StateNotifierProvider<ForgetPasswordUseCase, AsyncValue<String?>>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return ForgetPasswordUseCase(repo: authRepo);
});

final verifyPassResetCodeUseCaseProvider =
    StateNotifierProvider<VerifyPassResetCodeUseCase, AsyncValue<String?>>(
        (ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return VerifyPassResetCodeUseCase(repo: authRepo);
});

final resetPasswordUseCaseProvider =
    StateNotifierProvider<ResetPasswordUseCase, AsyncValue<SignInEntity?>>(
        (ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return ResetPasswordUseCase(repo: authRepo);
});

final getUserByTokenUseCaseProvider =
    StateNotifierProvider<GetUserByTokenUseCase, AsyncValue<UserEntity?>>(
        (ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return GetUserByTokenUseCase(repo: authRepo, ref: ref);
});
