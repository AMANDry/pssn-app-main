import 'package:pssn/common/business_objects/result.dart';

abstract class CredentialRemoteDataSource {
  Future<Result<Map<String, String>>> getCredentials([
    Map<String, String>? data,
  ]);
}
