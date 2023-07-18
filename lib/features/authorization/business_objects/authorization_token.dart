import 'package:freezed_annotation/freezed_annotation.dart';

part 'authorization_token.freezed.dart';

@freezed
class AuthorizationToken with _$AuthorizationToken {
  const factory AuthorizationToken({
    required String accessToken,
    required String refreshToken,
  }) = _AuthorizationToken;
}
