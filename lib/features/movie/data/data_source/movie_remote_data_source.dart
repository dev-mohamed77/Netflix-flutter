// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/download/data/model/movie_download_model.dart';
import 'package:netflix/features/movie/domain/entities/movie_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:netflix/core/service/network_service/network_service.dart';
import 'package:netflix/features/movie/data/model/movie_model.dart';
import 'package:rxdart/rxdart.dart';

abstract class MovieRemoteDataSource {
  Future<MovieModel> getMovieByID({required String id});
  Future<MovieDownloadModel> downloadMovie({
    required MovieEntity movie,
    required PublishSubject<int> downloadController,
  });
}

class MovieRemoteDataSourceImp extends MovieRemoteDataSource {
  final NetworkService networkService;
  MovieRemoteDataSourceImp({
    required this.networkService,
  });

  @override
  Future<MovieModel> getMovieByID({required String id}) async {
    final response = await networkService.getData("movies/$id");

    final data = response.data["result"];

    return MovieModel.fromMap(data);
  }

  @override
  Future<MovieDownloadModel> downloadMovie({
    required MovieEntity movie,
    required PublishSubject<int> downloadController,
  }) async {
    final path = await _localPath;
    final videoSave = "$path/${movie.title}${DateTime.now()}.mp4";
    final imageSave = "$path/${movie.title}${DateTime.now()}.png";

    await Future.wait([
      _downloadFile(
        url: movie.streamUrl,
        savePath: videoSave,
        progressCallback: (received, total) {
          final result = (received / total * 100).floor();
          downloadController.add(result);
        },
      ),
      _downloadFile(
        url: movie.imageUrl,
        savePath: imageSave,
        progressCallback: (received, total) {
          // final result = (received / total * 100).floor();
          // downloadController.add(result);
        },
      ),
    ]);

    final String movieSize = _fileSize(videoSave);

    final data = MovieDownloadModel(
      title: movie.title,
      image: imageSave,
      streamUrl: videoSave,
      movieSize: "$movieSize MB",
      time: movie.runtime,
    );
    return data;
  }

  String _fileSize(String path) {
    final file = File(path);

    final kb = file.readAsBytesSync().lengthInBytes / 1000;
    final mb = (kb / 1000).toStringAsFixed(2);

    return mb;
  }

  Future<Response<dynamic>> _downloadFile({
    required String url,
    required String savePath,
    required Function(int, int) progressCallback,
  }) {
    return networkService.downloadData(
      url,
      savePath: savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          progressCallback(received, total);
        }
      },
    );
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory!.path;
  }
}

final movieRemoteDataSourceProvider = Provider<MovieRemoteDataSource>(
  (ref) {
    final network = ref.watch(networkServiceProvider);

    return MovieRemoteDataSourceImp(networkService: network);
  },
);
