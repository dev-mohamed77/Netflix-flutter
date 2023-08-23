import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/auth/domain/entities/signin_entity.dart';
import 'package:netflix/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<ApiResult<SignInEntity>> signIn({
    required String email,
    required String password,
  });

  Future<ApiResult<UserEntity>> signUp({
    required String email,
    required String password,
  });

  Future<ApiResult<String>> forgetPassword({
    required String email,
  });

  Future<ApiResult<String>> verifyPassResetCode({
    required String resetCode,
  });

  Future<ApiResult<SignInEntity>> resetPassword({
    required String email,
    required String password,
  });

  Future<ApiResult<UserEntity>> getUserByToken({
    required String token,
  });
}
