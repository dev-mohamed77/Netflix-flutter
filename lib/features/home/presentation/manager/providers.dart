import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/home/data/repository_imp/home_repository_imp.dart';
import 'package:netflix/features/home/domain/entities/home_entity.dart';
import 'package:netflix/features/home/domain/usecase/get_home_usecase.dart';

final getHomeUseCaseProvider =
    StateNotifierProvider<GetHomeUseCase, AsyncValue<HomeEntity?>>((ref) {
  final repo = ref.watch(homeRepositoryProvider);

  return GetHomeUseCase(repo: repo);
});
