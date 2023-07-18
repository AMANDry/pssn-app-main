import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/sign_in/datasources/remote/credential_remote_data_source.dart';
import 'package:twitter_login/twitter_login.dart';

class TwitterCredentialRemoteDataSource extends CredentialRemoteDataSource {
  TwitterCredentialRemoteDataSource(TwitterLogin? twitterLogin)
      : _twitterLogin = twitterLogin ?? getIt();

  final TwitterLogin _twitterLogin;

  @override
  Future<Result<Map<String, String>>> getCredentials([
    Map<String, String>? data,
  ]) async {
    try {
      final auth = await _twitterLogin.login();
      return Result.success({
        'accessToken': auth.authToken.toString(),
        'secret': auth.authTokenSecret.toString(),
      });
    } on Exception catch (exception) {
      return Result.failed(AppUnknownException(exception.toString()));
    }
  }
}
