import 'package:dio/dio.dart';
import 'package:pssn/features/authorization/dtos/authorization_token_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'authorization_api.g.dart';

@RestApi()
abstract class AuthorizationApi {
  factory AuthorizationApi(Dio client) = _AuthorizationApi;

  @POST('/auth/token')
  Future<AuthorizationTokenDTO> getRemoteToken(
    @Body() Map<String, String?> data,
  );

  @GET('/test')
  Future<void> testCall();
}
