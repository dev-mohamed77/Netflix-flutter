// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/providers/token_local_provider.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final Ref ref;
  AuthInterceptor({
    required this.dio,
    required this.ref,
  });
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = ref.watch(tokenLocalProvider);
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response != null) {
      if (err.response!.statusCode == 401) {}
    } else {
      handler.next(err);
    }
    super.onError(err, handler);
  }
}
