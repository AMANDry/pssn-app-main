import 'dart:math';

import 'package:dio/dio.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/globals.dart';

class MockInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path == '/auth/token') {
      final data = tryCast<Map<String, String?>>(options.data);
      if (!(data?['email']?.contains('@') ?? false)) {
        return handler.resolve(
          Response<Map<String, dynamic>>(
            statusCode: 400,
            statusMessage: 'MOCK',
            data: <String, dynamic>{
              'error': 'Invalid email',
            },
            requestOptions: options,
          ),
        );
      }
      return handler.resolve(
        Response<Map<String, dynamic>>(
          statusCode: 200,
          statusMessage: 'MOCK',
          data: <String, dynamic>{
            "accessToken": Random.secure().nextInt(1000).toString(),
            "refreshToken": Random.secure().nextInt(1000).toString(),
          },
          requestOptions: options,
        ),
        true,
      );
    } else if (options.path == '/auth/refresh') {
      return handler.resolve(
        Response<Map<String, dynamic>>(
          statusCode: 200,
          statusMessage: 'MOCK',
          data: <String, dynamic>{
            "accessToken": Random.secure().nextInt(1000).toString(),
            "refreshToken": Random.secure().nextInt(1000).toString(),
          },
          requestOptions: options,
        ),
        true,
      );
    } else if (options.path == '/test') {
      // Mock refresh token call
      return handler.resolve(
        Response<Map<String, dynamic>>(
          statusCode: options.extra.containsKey('mock_200') ? 200 : 401,
          statusMessage: 'MOCK',
          requestOptions: options,
          data: options.extra.containsKey('mock_200')
              ? <String, dynamic>{"key": "value"}
              : null,
        ),
        true,
      );
    } else if (options.path == '/notification/token') {
      return handler.resolve(
        Response<bool>(
          statusCode: 200,
          statusMessage: 'MOCK',
          requestOptions: options,
          data: true,
        ),
        true,
      );
    } else if (options.path == '/profile') {
      await Future<void>.delayed(const Duration(seconds: 1));
      return handler.resolve(
        Response<Map<String, dynamic>>(
          statusCode: 200,
          statusMessage: 'MOCK',
          requestOptions: options,
          data: <String, dynamic>{
            "id": "0",
            "fullName": "Test User",
            "imageUrl": options.extra.containsKey('mock_profile_picture')
                ? "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg"
                : "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80",
          },
        ),
        true,
      );
    } else if (options.path == '/profile/picture') {
      await Future<void>.delayed(const Duration(seconds: 1));
      getIt<Dio>()
          .options
          .extra
          .addAll(<String, dynamic>{'mock_profile_picture': true});
      return handler.resolve(
        Response<String>(
          statusCode: 200,
          statusMessage: 'MOCK',
          requestOptions: options,
          data:
              "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80",
        ),
        true,
      );
    } else if (options.path == '/digitalid' && options.method == "GET") {
      await Future<void>.delayed(const Duration(seconds: 1));
      return handler.resolve(
        Response<Map<String, dynamic>>(
          statusCode: 200,
          statusMessage: 'MOCK',
          requestOptions: options,
          data: <String, dynamic>{
            "id": 1,
            "name": "Test User",
          },
        ),
        true,
      );
    } else if (options.path == '/digitalid' && options.method == "POST") {
      await Future<void>.delayed(const Duration(seconds: 1));
      return handler.resolve(
        Response<Map<String, dynamic>>(
          statusCode: 200,
          statusMessage: 'MOCK',
          requestOptions: options,
          data: <String, dynamic>{
            "id": 2,
            "name": "Test User 2",
          },
        ),
        true,
      );
    } else if (options.path == '/visit-requests') {
      if (options.method == 'GET') {
        await Future<void>.delayed(const Duration(seconds: 1));
        handler.resolve(
          Response<Map<String, dynamic>>(
            statusCode: 200,
            statusMessage: 'MOCK',
            requestOptions: options,
            data: <String, dynamic>{'id': 0},
          ),
          true,
        );
      } else if (options.method == 'POST') {
        await Future<void>.delayed(const Duration(seconds: 1));
        handler.resolve(
          Response<Map<String, dynamic>>(
            statusCode: 200,
            statusMessage: 'MOCK',
            requestOptions: options,
            data: <String, dynamic>{'id': 1},
          ),
          true,
        );
      }
    } else if (options.path == '/journey') {
      if (options.method == 'GET') {
        await Future<void>.delayed(const Duration(seconds: 1));
        handler.resolve(
          Response<Map<String, dynamic>>(
            statusCode: 200,
            statusMessage: 'MOCK',
            requestOptions: options,
            data: <String, dynamic>{
              "id": 1,
            },
          ),
          true,
        );
      } else if (options.method == 'POST') {
        await Future<void>.delayed(const Duration(seconds: 1));
        handler.resolve(
          Response<Map<String, dynamic>>(
            statusCode: 200,
            statusMessage: 'MOCK',
            requestOptions: options,
            data: <String, dynamic>{
              "id": 2,
            },
          ),
          true,
        );
      }
    } else if (options.path == '/notification/history') {
      if (options.method == 'GET') {
        await Future<void>.delayed(const Duration(seconds: 1));
        handler.resolve(
          Response<dynamic>(
            statusCode: 200,
            statusMessage: 'MOCK',
            requestOptions: options,
            data: <Map<String, dynamic>>[
              <String, dynamic>{
                'id': 0,
                'title': 'Notification 1',
                'createdAt': DateTime.now().toIso8601String()
              },
              <String, dynamic>{
                'id': 1,
                'title': 'Notification 2',
                'createdAt': DateTime.now()
                    .subtract(const Duration(seconds: 5))
                    .toIso8601String()
              },
              <String, dynamic>{
                'id': 2,
                'title': 'Notification 3',
                'createdAt': DateTime.now()
                    .subtract(const Duration(seconds: 2))
                    .toIso8601String()
              },
            ],
          ),
        );
      }
    } else if (options.path == '/sign-up') {
      if (options.method == 'POST') {
        await Future<void>.delayed(const Duration(seconds: 1));
        handler.resolve(
          Response<Map<String, dynamic>>(
            statusCode: 200,
            statusMessage: 'MOCK',
            requestOptions: options,
            data: <String, dynamic>{
              'id': 0,
            },
          ),
          true,
        );
      }
    } else if (options.path == '/verification') {
      if (options.method == 'POST') {
        await Future<void>.delayed(const Duration(seconds: 1));
        handler.resolve(
          Response<Map<String, dynamic>>(
            statusCode: 200,
            statusMessage: 'MOCK',
            requestOptions: options,
            data: <String, dynamic>{
              'isVerified': true,
            },
          ),
          true,
        );
      }
    } else {
      return handler.next(options);
    }
  }
}
