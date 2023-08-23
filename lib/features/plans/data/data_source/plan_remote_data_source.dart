import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/service/network_service/network_service.dart';
import 'package:netflix/features/auth/data/model/user_model.dart';
import 'package:netflix/features/plans/data/models/plan_model.dart';

abstract class PlanDataSource {
  Future<List<PlanModel>> getPlans();
  Future<UserModel> onSubscribePlan(String planID);
  Future<UserModel> onUnSubscribePlan();
}

class PlanRemoteDataSourceImp implements PlanDataSource {
  final NetworkService networkService;

  PlanRemoteDataSourceImp({required this.networkService});

  @override
  Future<List<PlanModel>> getPlans() async {
    final res = await networkService.getData("plans");

    final Iterable data = res.data["result"];

    final List<PlanModel> plans =
        data.map((plan) => PlanModel.fromMap(plan)).toList();

    return plans;
  }

  @override
  Future<UserModel> onSubscribePlan(String planID) async {
    final res = await networkService.putData("plans/$planID/subscribed");

    final data = res.data["result"];

    return UserModel.fromMap(data);
  }

  @override
  Future<UserModel> onUnSubscribePlan() async {
    final res = await networkService.putData("plans/unsubscribed");
    final data = res.data["result"];

    return UserModel.fromMap(data);
  }
}

final planRemoteDataSourceProvider = Provider((ref) {
  final network = ref.watch(networkServiceProvider);
  return PlanRemoteDataSourceImp(networkService: network);
});
