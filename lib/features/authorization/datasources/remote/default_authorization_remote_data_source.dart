import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/extensions.dart';
import 'package:pssn/features/authorization/business_objects/authorization_token.dart';
import 'package:pssn/features/authorization/datasources/api/authorization_api.dart';
import 'package:pssn/features/authorization/datasources/api/token_refresh_api.dart';
import 'package:pssn/features/authorization/datasources/remote/authorization_remote_data_source.dart';

class DefaultAuthorizationRemoteDataSource
    implements AuthorizationRemoteDataSource {
  DefaultAuthorizationRemoteDataSource(
    AuthorizationApi? authorizationApi,
    TokenRefreshApi? tokenRefreshApi,
  )   : _authorizationApi = authorizationApi ?? getIt(),
        _tokenRefreshApi = tokenRefreshApi ?? getIt();

  final TokenRefreshApi _tokenRefreshApi;
  final AuthorizationApi _authorizationApi;

  @override
  Future<Result<AuthorizationToken>> getRemoteToken(
    Map<String, String?> credentials,
  ) async {
    return _authorizationApi
        .getRemoteToken(credentials)
        .toResult(mapper: (dto) => dto.toBO());
  }

  @override
  Future<Result<AuthorizationToken>> refreshToken() async {
    return _tokenRefreshApi
        .refreshToken()
        .toResult(mapper: (dto) => dto.toBO());
  }

  @override
  Future<void> testCall() async {
    return _authorizationApi.testCall();
  }
}
