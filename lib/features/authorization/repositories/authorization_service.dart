import 'dart:async';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/authorization/business_objects/authorization_token.dart';
import 'package:pssn/features/authorization/datasources/local/authorization_local_data_source.dart';
import 'package:pssn/features/authorization/datasources/remote/authorization_remote_data_source.dart';

abstract class AuthorizationService {
  late final Stream<bool> isAuthorized;

  Future<AuthorizationToken?> get token;

  // ignore: unused_element
  Future<Result<AuthorizationToken>> _getLocalToken();

  Future<Result<AuthorizationToken>> getRemoteToken(
    Map<String, String?> credentials,
  );

  Future<Result<AuthorizationToken>> refreshToken();

  Future<Result<void>> removeLocalToken();

  Future<void> testCall();
}

class DefaultAuthorizationService extends AuthorizationService {
  DefaultAuthorizationService({
    required AuthorizationLocalDataSource? authorizationLocalDataSource,
    required AuthorizationRemoteDataSource? authorizationRemoteDataSource,
  })  : _authorizationLocalDataSource = authorizationLocalDataSource ?? getIt(),
        _authorizationRemoteDataSource =
            authorizationRemoteDataSource ?? getIt(),
        _isAuthorizedController = StreamController.broadcast();

  final StreamController<bool> _isAuthorizedController;
  final AuthorizationLocalDataSource _authorizationLocalDataSource;
  final AuthorizationRemoteDataSource _authorizationRemoteDataSource;

  @override
  Stream<bool> get isAuthorized => _isAuthorizedController.stream;

  @override
  Future<AuthorizationToken?> get token async {
    final result = await _getLocalToken();

    return result.whenOrNull(success: (token) => token);
  }

  @override
  Future<Result<AuthorizationToken>> _getLocalToken() async {
    final result = await _authorizationLocalDataSource.getLocalToken();

    result.when(
      success: (token) {
        _isAuthorizedController.add(true);
      },
      failed: (_) {
        _isAuthorizedController.add(false);
      },
    );

    return result;
  }

  @override
  Future<Result<AuthorizationToken>> getRemoteToken(
    Map<String, String?> credentials,
  ) async {
    final result =
        await _authorizationRemoteDataSource.getRemoteToken(credentials);

    await result.whenOrNull(
      success: (token) async {
        _isAuthorizedController.add(true);

        await _authorizationLocalDataSource.putLocalToken(token);
      },
      failed: (_) {
        _isAuthorizedController.add(false);
      },
    );

    return result;
  }

  @override
  Future<Result<AuthorizationToken>> refreshToken() async {
    final result = await _authorizationRemoteDataSource.refreshToken();

    await result.whenOrNull(
      success: (token) async {
        await _authorizationLocalDataSource.putLocalToken(token);
      },
      failed: (_) {
        _authorizationLocalDataSource.removeLocalToken();
        _isAuthorizedController.add(false);
      },
    );

    return result;
  }

  @override
  Future<Result<bool>> removeLocalToken() {
    final result = _authorizationLocalDataSource.removeLocalToken();

    _isAuthorizedController.add(false);

    return result;
  }

  @override
  Future<void> testCall() {
    final result = _authorizationRemoteDataSource.testCall();

    return result;
  }
}
