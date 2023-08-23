// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:netflix/core/service/local_service/providers.dart';

import 'package:netflix/core/service/local_service/shared_keys.dart';

import '../../../download/data/model/movie_download_model.dart';

abstract class MovieLocalDataSource {
  Future<void> downloadMovie({
    required MovieDownloadModel movieDownloadModel,
  });
  Future<bool> addDownloadWifiOnly({
    required bool isCheckDownloadWifiOnly,
  });

  Future<Object?> getDownloadWifiOnly();
}

class MovieLocalDataSourceImp implements MovieLocalDataSource {
  final Ref ref;
  MovieLocalDataSourceImp({
    required this.ref,
  });

  @override
  Future<void> downloadMovie({
    required MovieDownloadModel movieDownloadModel,
  }) async {
    var box = Hive.box<MovieDownloadModel>(SharedPrefKeys.downloadMovieKey);

    box.add(movieDownloadModel);
  }

  @override
  Future<bool> addDownloadWifiOnly({
    required bool isCheckDownloadWifiOnly,
  }) async {
    final sharedService = await ref.watch(sharedServiceProvider);

    return sharedService.setData(
      key: SharedPrefKeys.downloadWifiOnlyKey,
      value: isCheckDownloadWifiOnly,
    );
  }

  @override
  Future<Object?> getDownloadWifiOnly() async {
    final sharedService = await ref.watch(sharedServiceProvider);
    return sharedService.getData(SharedPrefKeys.downloadWifiOnlyKey);
  }
}

final movieLocalDataSourceProvider = Provider<MovieLocalDataSource>(
  (ref) {
    return MovieLocalDataSourceImp(ref: ref);
  },
);
