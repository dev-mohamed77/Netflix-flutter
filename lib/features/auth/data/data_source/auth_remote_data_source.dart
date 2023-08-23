import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/service/network_service/network_service.dart';
import 'package:netflix/features/auth/data/model/signin_model.dart';
import 'package:netflix/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<SignInModel> signIn({
    required String email,
    required String password,
  });

  Future<UserModel> signUp({
    required String email,
    required String password,
  });

  Future<String> forgetPassword({
    required String email,
  });

  Future<String> verifyPassResetCode({
    required String resetCode,
  });

  Future<SignInModel> resetPassword({
    required String email,
    required String password,
  });

  Future<UserModel> getUserByToken({
    required String token,
  });
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  AuthRemoteDataSourceImp({
    required this.networkService,
  });

  final NetworkService networkService;

  @override
  Future<SignInModel> signIn({
    required String email,
    required String password,
  }) async {
    final res = await networkService.postData("auth/signin", data: {
      "email": email,
      "password": password,
    });

    final responseData = res.data["result"];

    return SignInModel.fromMap(responseData);
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
  }) async {
    final res = await networkService.postData("auth/signup", data: {
      "email": email,
      "password": password,
    });

    final responseData = res.data["result"];

    return UserModel.fromMap(responseData);
  }

  @override
  Future<String> forgetPassword({
    required String email,
  }) async {
    final res = await networkService.postData(
      "auth/forget-password",
      data: {
        "email": email,
      },
    );

    final responseData = res.data["result"];

    return responseData;
  }

  @override
  Future<String> verifyPassResetCode({
    required String resetCode,
  }) async {
    final res = await networkService.postData(
      "auth/verify-pass-resetCode",
      data: {
        "resetCode": resetCode,
      },
    );

    final responseData = res.data["result"];

    return responseData;
  }

  @override
  Future<SignInModel> resetPassword({
    required String email,
    required String password,
  }) async {
    final res = await networkService.putData(
      "auth/reset-password",
      data: {
        "email": email,
        "password": password,
      },
    );

    final responseData = res.data["result"];

    return SignInModel.fromMap(responseData);
  }

  @override
  Future<UserModel> getUserByToken({
    required String token,
  }) async {
    final res = await networkService.getData("users/getMe", token: token);
    final responseData = res.data["result"];

    return UserModel.fromMap(responseData);
  }
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dioService = ref.watch(networkServiceProvider);
  return AuthRemoteDataSourceImp(networkService: dioService);
});
