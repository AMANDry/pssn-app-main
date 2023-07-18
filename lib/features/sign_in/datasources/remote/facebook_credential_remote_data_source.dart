import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/sign_in/datasources/remote/credential_remote_data_source.dart';

class FacebookCredentialRemoteDataSource extends CredentialRemoteDataSource {
  FacebookCredentialRemoteDataSource(FacebookAuth? facebookAuth)
      : _facebookAuth = facebookAuth ?? getIt();

  final FacebookAuth _facebookAuth;

  @override
  Future<Result<Map<String, String>>> getCredentials([
    Map<String, String>? data,
  ]) async {
    try {
      final login = await _facebookAuth.login();
      return Result.success({
        'accessToken': login.accessToken.toString(),
      });
    } on Exception catch (exception) {
      return Result.failed(AppUnknownException(exception.toString()));
    }
  }
}
