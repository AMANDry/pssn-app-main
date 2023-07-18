import 'package:dio/dio.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/extensions.dart';
import 'package:pssn/common/helpers/logging_mixin.dart';
import 'package:pssn/features/authorization/repositories/authorization_service.dart';

class RefreshInterceptor extends QueuedInterceptor with AppLoggingMixin {
  RefreshInterceptor(Dio tokenRefreshClient)
      : _tokenRefreshClient = tokenRefreshClient;

  final Dio _tokenRefreshClient;
  MapEntry<String, String> authorizationHeader(String accessToken) =>
      MapEntry('Authorization', 'Bearer $accessToken');

  // Add current token to the request
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getIt<AuthorizationService>().token;

    if (token != null) {
      options.headers.addEntries([authorizationHeader(token.accessToken)]);
    }
    printInfo(
      '${options.method} request to ${options.uri} \nHeaders: ${(options.headers).toString().throttled()} \nData: ${(options.data ?? '').toString().throttled()}',
    );
    return handler.next(options);
  }

  // Check current token and response status, refresh it and repeat the request
  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    printInfo(
      'Response for ${response.requestOptions.method} from ${response.realUri}:\nStatus code: ${response.statusCode} ${response.statusMessage}\nData: ${(response.data ?? '').toString().throttled()}',
    );
    final authorizationService = getIt<AuthorizationService>();

    final currentToken = await authorizationService.token;

    if (currentToken != null && response.statusCode == 401) {
      try {
        await authorizationService.refreshToken();

        final refreshToken = await authorizationService.token;

        if (refreshToken != null) {
          final repeatResponse = await _tokenRefreshClient.request<dynamic>(
            response.requestOptions.path,
            cancelToken: response.requestOptions.cancelToken,
            data: response.requestOptions.data,
            onReceiveProgress: response.requestOptions.onReceiveProgress,
            onSendProgress: response.requestOptions.onSendProgress,
            queryParameters: response.requestOptions.queryParameters,
            options: Options(
              headers: response.requestOptions.headers
                ..addEntries([authorizationHeader(refreshToken.accessToken)]),
              extra: response.requestOptions.extra
                ..addAll(<String, dynamic>{'mock_200': true}),
              method: response.requestOptions.method,
              listFormat: response.requestOptions.listFormat,
              sendTimeout: response.requestOptions.sendTimeout,
              contentType: response.requestOptions.contentType,
              responseType: response.requestOptions.responseType,
              maxRedirects: response.requestOptions.maxRedirects,
              receiveTimeout: response.requestOptions.receiveTimeout,
              validateStatus: response.requestOptions.validateStatus,
              requestEncoder: response.requestOptions.requestEncoder,
              responseDecoder: response.requestOptions.responseDecoder,
              followRedirects: response.requestOptions.followRedirects,
              receiveDataWhenStatusError:
                  response.requestOptions.receiveDataWhenStatusError,
            ),
          );

          return handler.resolve(repeatResponse);
        }
      } on DioError catch (error) {
        return handler.reject(error);
      }
    }
    return handler.next(response);
  }

  // TODO(): Implement on error
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    printError(
      'Request to ${err.requestOptions.uri} has failed:\nError type: ${err.type}\nError message: ${err.message}',
    );
    return handler.next(err);
  }
}
