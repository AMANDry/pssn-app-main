import 'dart:core';

import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  AppException(this.message);

  final String message;
}

class AppNetworkException extends AppException implements DioError {
  AppNetworkException({
    required String message,
    required this.type,
    required this.requestOptions,
    this.error,
    this.response,
    this.stackTrace = StackTrace.empty,
  }) : super(message);

  @override
  DioErrorType type;

  @override
  RequestOptions requestOptions;

  @override
  Object? error;

  @override
  Response? response;

  @override
  StackTrace stackTrace;

  @override
  AppNetworkException copyWith({
    Object? error,
    String? message,
    DioErrorType? type,
    StackTrace? stackTrace,
    Response<dynamic>? response,
    RequestOptions? requestOptions,
  }) {
    return AppNetworkException(
      type: type ?? this.type,
      error: error ?? this.error,
      message: message ?? this.message,
      response: response ?? this.response,
      stackTrace: stackTrace ?? this.stackTrace,
      requestOptions: requestOptions ?? this.requestOptions,
    );
  }
}

class AppConnectionException extends AppNetworkException {
  AppConnectionException({
    required super.type,
    required super.message,
    required super.requestOptions,
    super.stackTrace,
  });
}

class AppServerException extends AppException {
  AppServerException(super.message);
}

class AppUnknownException extends AppException {
  AppUnknownException(super.message);
}
