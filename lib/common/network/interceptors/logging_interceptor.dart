import 'package:dio/dio.dart';
import 'package:pssn/common/helpers/extensions.dart';
import 'package:pssn/common/helpers/logging_mixin.dart';

class LoggingInterceptor extends Interceptor with AppLoggingMixin {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printInfo(
      '${options.method} request to ${options.uri} \nData: ${(options.data ?? '').toString().throttled()}',
    );

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printInfo(
      'Response for ${response.requestOptions.method} from ${response.realUri} \nRequest headers: ${(response.requestOptions.headers).toString().throttled()}:\nStatus code: ${response.statusCode} ${response.statusMessage}\nData: ${(response.data ?? '').toString().throttled()}',
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    printError(
      'Request to ${err.requestOptions.uri} has failed:\nError type: ${err.type}\nError message: ${err.message}',
    );

    super.onError(err, handler);
  }
}
