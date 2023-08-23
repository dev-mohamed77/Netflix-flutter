// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/service/network_service/network_service.dart';
import 'package:netflix/features/home/data/model/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHome();
}

class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final NetworkService networkService;
  HomeRemoteDataSourceImp({
    required this.networkService,
  });
  @override
  Future<HomeModel> getHome() async {
    final res = await networkService.getData("");

    final data = res.data;

    return HomeModel.fromMap(data);
  }
}

final homeRemoteDataSourceProvider = Provider((ref) {
  final network = ref.watch(networkServiceProvider);
  return HomeRemoteDataSourceImp(networkService: network);
});
