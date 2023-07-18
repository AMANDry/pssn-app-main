import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/authorization/business_objects/authorization_token.dart';

abstract class AuthorizationLocalDataSource {
  Future<Result<AuthorizationToken>> getLocalToken();
  Future<Result<bool>> removeLocalToken();
  Future<Result<AuthorizationToken>> putLocalToken(AuthorizationToken token);
}
