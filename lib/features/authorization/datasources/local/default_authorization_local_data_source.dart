import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/authorization/business_objects/authorization_token.dart';
import 'package:pssn/features/authorization/datasources/local/authorization_local_data_source.dart';
import 'package:pssn/features/authorization/dtos/authorization_token_dto.dart';

class DefaultAuthorizationLocalDataSource
    implements AuthorizationLocalDataSource {
  DefaultAuthorizationLocalDataSource(
    FlutterSecureStorage? secureStorage,
  ) : _secureStorage = secureStorage ?? getIt();

  final String _tokenKey = 'authToken';
  final FlutterSecureStorage _secureStorage;

  @override
  Future<Result<AuthorizationToken>> getLocalToken() async {
    try {
      final tokenDTOJsonString = await _secureStorage.read(key: _tokenKey);
      if (tokenDTOJsonString != null) {
        final tokenDTOJson =
            jsonDecode(tokenDTOJsonString) as Map<String, dynamic>;

        final token = AuthorizationTokenDTO.fromJson(tokenDTOJson).toBO();

        return Result.success(token);
      }
      return Result.failed(
        AppUnknownException("Can't read token from storage"),
      );
    } on Object catch (exception) {
      _secureStorage.delete(key: _tokenKey);
      return Result.failed(AppUnknownException(exception.toString()));
    }
  }

  @override
  Future<Result<AuthorizationToken>> putLocalToken(
    AuthorizationToken token,
  ) async {
    try {
      final tokenDTO = AuthorizationTokenDTO.fromBO(token);
      final tokenDTOJson = tokenDTO.toJson();
      final tokenDTOJsonString = jsonEncode(tokenDTOJson);

      await _secureStorage.delete(key: _tokenKey);
      await _secureStorage.write(key: _tokenKey, value: tokenDTOJsonString);

      return Result.success(token);
    } on Object catch (exception) {
      _secureStorage.delete(key: _tokenKey);
      return Result.failed(AppUnknownException(exception.toString()));
    }
  }

  @override
  Future<Result<bool>> removeLocalToken() async {
    try {
      await _secureStorage.delete(key: _tokenKey);

      return const Result.success(true);
    } on Object catch (exception) {
      return Result.failed(AppUnknownException(exception.toString()));
    }
  }
}
