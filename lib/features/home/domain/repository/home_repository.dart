import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/home/domain/entities/home_entity.dart';

abstract class HomeRepository {
  Future<ApiResult<HomeEntity>> home();
}
