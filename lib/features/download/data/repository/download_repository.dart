// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/core/service/local_service/shared_keys.dart';
import 'package:netflix/features/download/data/data_source/download_data_source.dart';
import 'package:netflix/features/download/data/model/movie_download_model.dart';
import 'package:netflix/features/download/domain/repository/download_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadRepositoryImp implements DownloadRepository {
  final DownloadDataSource dataSource;
  DownloadRepositoryImp({
    required this.dataSource,
  });

  @override
  Future<ApiResult<List<FileSystemEntity>>> deleteMovieFromLocalStorage({
    required String pathStream,
    required String pathImage,
  }) async {
    try {
      var status = await Permission.storage.status;

      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final List<FileSystemEntity> result =
          await dataSource.deleteMovieFromLocalStorage(
        pathStream: pathStream,
        pathImage: pathImage,
      );

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(
        ErrorHandle.getDioException(err),
      );
    }
  }

  @override
  Future<ApiResult<String>> deleteAllMoviesFromLocalStorage() async {
    try {
      final result = await dataSource.deleteAllMoviesFromLocalStorage();
      final box = await Hive.openBox<MovieDownloadModel>(
          SharedPrefKeys.downloadMovieKey);

      await box.clear();

      return ApiResult.success(result);
    } catch (err) {
      return ApiResult.failure(
        ErrorHandle.getDioException(err),
      );
    }
  }
}

final downloadRepositoryProvider = Provider((ref) {
  final dataSource = ref.watch(downloadDataSourceProvider);
  return DownloadRepositoryImp(dataSource: dataSource);
});
