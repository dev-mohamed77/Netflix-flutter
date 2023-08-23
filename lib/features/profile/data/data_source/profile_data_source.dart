// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/service/network_service/network_service.dart';
import 'package:netflix/features/auth/data/model/signin_model.dart';

import '../../../auth/data/model/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> updateUser({
    String? fullName,
    String? phone,
    String? gender,
  });

  Future<SignInModel> changePassword({
    required String password,
    required String currentPassword,
  });
}

class ProfileRemoteDataSourceImp extends ProfileRemoteDataSource {
  final NetworkService networkService;

  ProfileRemoteDataSourceImp({
    required this.networkService,
  });

  @override
  Future<UserModel> updateUser({
    String? fullName,
    String? phone,
    String? gender,
  }) async {
    final response = await networkService.putData(
      "users/update-user",
      data: {
        "fullName": fullName,
        "phone": phone,
        "gender": gender,
      },
    );

    final data = response.data["result"];

    return UserModel.fromMap(data);
  }

  @override
  Future<SignInModel> changePassword({
    required String password,
    required String currentPassword,
  }) async {
    final response = await networkService.putData(
      "users/change-password",
      data: {
        "currentPassword": currentPassword,
        "password": password,
      },
    );

    final data = response.data["result"];

    return SignInModel.fromMap(data);
  }
}

final profileDataSourceProvider = Provider<ProfileRemoteDataSource>((ref) {
  final network = ref.watch(networkServiceProvider);

  return ProfileRemoteDataSourceImp(networkService: network);
});
