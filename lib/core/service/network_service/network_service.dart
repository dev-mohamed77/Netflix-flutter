import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_intercepters.dart';

abstract class NetworkService {
  Future<Response> getData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    String? token,
  });
  Future<Response> postData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = false,
    String? token,
  });
  Future<Response> putData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = false,
    String? token,
  });
  Future<Response> deleteData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = false,
    String? token,
  });

  Future<Response> downloadData(
    String path, {
    required dynamic savePath,
    void Function(int, int)? onReceiveProgress,
    CancelToken? cancelToken,
  });
}

class DioService implements NetworkService {
  late Dio dio;
  final Ref ref;
  DioService._({required this.ref}) {
    dio = Dio(BaseOptions(
      baseUrl: "http://192.168.1.7:3000/",
      receiveDataWhenStatusError: true,
      sendTimeout: const Duration(seconds: 15),
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      followRedirects: false,
    ));
    dio.interceptors.add(
      AuthInterceptor(dio: dio, ref: ref),
    );
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      error: true,
      responseBody: true,
      responseHeader: true,
    ));
  }

  factory DioService({required Ref ref}) => DioService._(ref: ref);

  @override
  Future<Response> getData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio.get(
      path,
      data: data,
      queryParameters: queryParams,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  @override
  Future<Response> postData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = false,
    String? token,
  }) async {
    return await dio.post(
      path,
      data: isFormData ? FormData.fromMap(data!) : data,
      queryParameters: queryParams,
      options: Options(headers: {
        "Authorization": token,
      }),
    );
  }

  @override
  Future<Response> putData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = false,
    String? token,
  }) async {
    return await dio.put(
      path,
      data: isFormData ? FormData.fromMap(data!) : data,
      queryParameters: queryParams,
      options: Options(headers: {
        "Authorization": token,
      }),
    );
  }

  @override
  Future<Response> deleteData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = false,
    String? token,
  }) async {
    return await dio.delete(
      path,
      data: isFormData ? FormData.fromMap(data!) : data,
      queryParameters: queryParams,
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
  }

  @override
  Future<Response> downloadData(
    String path, {
    required dynamic savePath,
    void Function(int, int)? onReceiveProgress,
    CancelToken? cancelToken,
  }) {
    return dio.download(
      path,
      savePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      deleteOnError: true,
    );
  }
}

final networkServiceProvider = Provider<NetworkService>((ref) {
  return DioService(ref: ref);
});
