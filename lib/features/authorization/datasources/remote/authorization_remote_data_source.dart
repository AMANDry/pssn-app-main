import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/authorization/business_objects/authorization_token.dart';

abstract class AuthorizationRemoteDataSource {
  Future<Result<AuthorizationToken>> getRemoteToken(
    Map<String, String?> credentials,
  );

  Future<Result<AuthorizationToken>> refreshToken();

  Future<void> testCall();
}
