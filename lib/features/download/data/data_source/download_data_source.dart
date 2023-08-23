// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/service/network_service/network_service.dart';
import 'package:path_provider/path_provider.dart';

abstract class DownloadDataSource {
  Future<List<FileSystemEntity>> deleteMovieFromLocalStorage({
    required String pathStream,
    required String pathImage,
  });

  Future<String> deleteAllMoviesFromLocalStorage();
}

class DownloadDataSourceImp implements DownloadDataSource {
  final NetworkService networkService;
  DownloadDataSourceImp({
    required this.networkService,
  });

  @override
  Future<List<FileSystemEntity>> deleteMovieFromLocalStorage({
    required String pathStream,
    required String pathImage,
  }) async {
    final result = await Future.wait([
      File(pathStream).delete(),
      File(pathImage).delete(),
    ]);

    return result;
  }

  @override
  Future<String> deleteAllMoviesFromLocalStorage() async {
    final path = await _localPath;

    final dir = Directory(path);

    dir.listSync().forEach((entity) {
      if (entity is File) {
        entity.deleteSync();
      }
    });

    return "All downloaded files have been successfully deleted";
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory!.path;
  }

  // List<File> _mp4FilesInDirectory(List<FileSystemEntity> files) {
  //   return files
  //       .where(
  //           (file) => file is File && file.path.toLowerCase().endsWith(".mp4"))
  //       .map((file) => File(file.path))
  //       .toList();
  // }
}

final downloadDataSourceProvider = Provider((ref) {
  final network = ref.watch(networkServiceProvider);
  return DownloadDataSourceImp(networkService: network);
});
