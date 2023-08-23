// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/core/providers/user_local_provider.dart';
import 'package:netflix/features/auth/domain/entities/signin_entity.dart';
import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/auth/domain/repositories/auth_repository.dart';

import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final Ref ref;
  AuthRepositoryImp({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.ref,
  });

  @override
  Future<ApiResult<SignInEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final res = await authRemoteDataSource.signIn(
        email: email,
        password: password,
      );
      final data = res;

      ref.read(userLocalProvider.notifier).setUser(data.user);

      await authLocalDataSource.addToken(data.token);

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<UserEntity>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final res = await authRemoteDataSource.signUp(
        email: email,
        password: password,
      );

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> forgetPassword({required String email}) async {
    try {
      final res = await authRemoteDataSource.forgetPassword(
        email: email,
      );

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<String>> verifyPassResetCode(
      {required String resetCode}) async {
    try {
      final res = await authRemoteDataSource.verifyPassResetCode(
        resetCode: resetCode,
      );

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<SignInEntity>> resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await authRemoteDataSource.resetPassword(
        email: email,
        password: password,
      );
      await authLocalDataSource.addToken(res.token);

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<UserEntity>> getUserByToken({required String token}) async {
    try {
      final response = await authRemoteDataSource.getUserByToken(token: token);
      return ApiResult.success(response);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}

final authRepositoryProvider = Provider((ref) {
  final authRemoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final authLocalDataSource = ref.watch(authLocalDataSourceProvider);

  return AuthRepositoryImp(
    authRemoteDataSource: authRemoteDataSource,
    authLocalDataSource: authLocalDataSource,
    ref: ref,
  );
});
