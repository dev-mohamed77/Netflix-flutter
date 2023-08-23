// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import 'package:netflix/core/api/api_error_handle.dart';
import 'package:netflix/core/api/api_result.dart';
import 'package:netflix/features/download/data/model/movie_download_model.dart';
import 'package:netflix/features/movie/data/data_source/movie_local_data_source.dart';
import 'package:netflix/features/movie/data/data_source/movie_remote_data_source.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';
import 'package:netflix/features/movie/domain/repository/movie_repository.dart';

import '../../../../core/service/check_internet_connection/check_internet_connect.dart';

class MovieRepositoryImp extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final Ref ref;
  MovieRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.ref,
  });

  @override
  Future<ApiResult<MovieEntity>> getMovieById({required String id}) async {
    try {
      final res = await remoteDataSource.getMovieByID(id: id);

      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }

  @override
  Future<ApiResult<MovieDownloadModel>> downloadMovie({
    required MovieEntity movie,
    required PublishSubject<int> downloadController,
  }) async {
    try {
      final isDownloadWifiOnly = await localDataSource.getDownloadWifiOnly();

      if (isDownloadWifiOnly != null) {
        if (isDownloadWifiOnly == true) {
          final isCheckConnectivity =
              await ref.watch(checkInternetConnection).isConnect;
          if (isCheckConnectivity == ConnectivityResult.wifi) {
            final res = await remoteDataSource.downloadMovie(
              movie: movie,
              downloadController: downloadController,
            );
            await localDataSource.downloadMovie(movieDownloadModel: res);
            return ApiResult.success(res);
          } else {
            return ApiResult.failure(const ErrorHandle.notFound(
                "Please connect to Wi-Fi to download data."));
          }
        } else {
          final res = await remoteDataSource.downloadMovie(
            movie: movie,
            downloadController: downloadController,
          );
          await localDataSource.downloadMovie(movieDownloadModel: res);
          return ApiResult.success(res);
        }
      }
      final res = await remoteDataSource.downloadMovie(
        movie: movie,
        downloadController: downloadController,
      );
      await localDataSource.downloadMovie(movieDownloadModel: res);
      return ApiResult.success(res);
    } catch (err) {
      return ApiResult.failure(ErrorHandle.getDioException(err));
    }
  }
}

final movieRepositoryProvider = Provider<MovieRepositoryImp>(
  (ref) {
    final remoteDataSource = ref.watch(movieRemoteDataSourceProvider);
    final localDataSource = ref.watch(movieLocalDataSourceProvider);
    return MovieRepositoryImp(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      ref: ref,
    );
  },
);
