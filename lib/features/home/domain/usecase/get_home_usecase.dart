import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/features/home/domain/entities/home_entity.dart';
import 'package:netflix/features/home/domain/repository/home_repository.dart';

class GetHomeUseCase extends StateNotifier<AsyncValue<HomeEntity?>> {
  final HomeRepository repo;
  GetHomeUseCase({
    required this.repo,
  }) : super(const AsyncValue.data(null)) {
    execute();
  }

  Future<void> execute() async {
    state = const AsyncLoading();

    final result = await repo.home();

    if (mounted) {
      state = result.when(
        success: (data) {
          return AsyncValue.data(data);
        },
        failure: (errorHandle) => AsyncValue.error(
          ErrorHandle.getErrorMessage(errorHandle),
          StackTrace.empty,
        ),
      );
    }
  }

  @override
  void dispose() {
    state;
    super.dispose();
  }
}
