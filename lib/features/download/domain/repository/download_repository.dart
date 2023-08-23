import 'dart:io';

import 'package:netflix/core/api/api_result.dart';

abstract class DownloadRepository {
  Future<ApiResult<List<FileSystemEntity>>> deleteMovieFromLocalStorage({
    required String pathStream,
    required String pathImage,
  });

  Future<ApiResult<String>> deleteAllMoviesFromLocalStorage();
}
