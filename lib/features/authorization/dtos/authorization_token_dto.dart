import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/authorization/business_objects/authorization_token.dart';

part 'authorization_token_dto.freezed.dart';
part 'authorization_token_dto.g.dart';

@freezed
class AuthorizationTokenDTO with _$AuthorizationTokenDTO {
  const factory AuthorizationTokenDTO({
    @Default('') String accessToken,
    @Default('') String refreshToken,
  }) = _AuthorizationTokenDTO;

  const AuthorizationTokenDTO._();

  AuthorizationToken toBO() => AuthorizationToken(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

  factory AuthorizationTokenDTO.fromBO(AuthorizationToken token) =>
      AuthorizationTokenDTO(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      );

  factory AuthorizationTokenDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationTokenDTOFromJson(json);
}
