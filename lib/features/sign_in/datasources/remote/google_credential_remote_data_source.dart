import 'package:google_sign_in/google_sign_in.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/sign_in/datasources/remote/credential_remote_data_source.dart';

class GoogleCredentialRemoteDataSource extends CredentialRemoteDataSource {
  GoogleCredentialRemoteDataSource(GoogleSignIn? googleSignIn)
      : _googleSignIn = googleSignIn ?? getIt();

  final GoogleSignIn _googleSignIn;

  @override
  Future<Result<Map<String, String>>> getCredentials([
    Map<String, String>? data,
  ]) async {
    try {
      final account = await _googleSignIn.signIn();
      final auth = await account?.authentication;
      if (auth == null) {
        return Result.failed(
          AppUnknownException('Google Authentication is null'),
        );
      }
      return Result.success({
        'accessToken': auth.accessToken.toString(),
        'idToken': auth.idToken.toString(),
      });
    } catch (exception) {
      return Result.failed(AppUnknownException(exception.toString()));
    }
  }
}
