import 'package:dio/dio.dart';
import 'package:pssn/features/authorization/dtos/authorization_token_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'token_refresh_api.g.dart';

@RestApi()
abstract class TokenRefreshApi {
  factory TokenRefreshApi(Dio client) = _TokenRefreshApi;

  @GET('/auth/refresh')
  Future<AuthorizationTokenDTO> refreshToken();
}
