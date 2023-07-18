import 'package:dio/dio.dart';

class NetworkManager {
  NetworkManager._();

  static Dio getApiDioClient({
    required Uri? baseUrl,
    int sendTimeout = 20000,
    int connectTimeout = 20000,
    int receiveTimeout = 20000,
    List<Interceptor> interceptors = const [],
  }) {
    final options = BaseOptions(
      sendTimeout: Duration(milliseconds: sendTimeout),
      connectTimeout: Duration(milliseconds: connectTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
    )..baseUrl = baseUrl.toString();

    final client = Dio(options)..interceptors.addAll(interceptors);

    return client;
  }
}
