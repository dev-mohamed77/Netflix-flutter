// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/core/providers/user_local_provider.dart';
import 'package:netflix/features/auth/data/model/signin_model.dart';
import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/profile/data/data_source/profile_data_source.dart';
import 'package:netflix/features/profile/data/data_source/profile_local_data_source.dart';

import '../../domain/repository/profile_repository.dart';

class ProfileRepositoryImp extends ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  final Ref ref;

  ProfileRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.ref,
  });

  @override
  Future<ApiResult<UserEntity>> updateUser({
    String? fullName,
    String? phone,
    String? gender,
  }) async {
    try {
      final res = await remoteDataSource.updateUser(
        fullName: fullName,
        phone: phone,
        gender: gender,
      );

      ref.read(userLocalProvider.notifier).setUser(res);

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<SignInModel>> changePassword({
    required String password,
    required String currentPassword,
  }) async {
    try {
      final res = await remoteDataSource.changePassword(
        password: password,
        currentPassword: currentPassword,
      );

      await localDataSource.addToken(res.token);

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remoteDataSource = ref.watch(profileDataSourceProvider);
  final localDataSource = ref.watch(profileLocalDataSourceProvider);

  return ProfileRepositoryImp(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    ref: ref,
  );
});
