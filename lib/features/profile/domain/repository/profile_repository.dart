import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/auth/data/model/signin_model.dart';
import 'package:netflix/features/auth/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<ApiResult<UserEntity>> updateUser({
    String? fullName,
    String? phone,
    String? gender,
  });

  Future<ApiResult<SignInModel>> changePassword({
    required String password,
    required String currentPassword,
  });
}
