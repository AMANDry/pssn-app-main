import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/sign_in/datasources/remote/credential_remote_data_source.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleCredentialRemoteDataSource extends CredentialRemoteDataSource {
  AppleCredentialRemoteDataSource();

  @override
  Future<Result<Map<String, String>>> getCredentials([
    Map<String, String>? data,
  ]) async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      return Result.success({
        'idToken': appleCredential.identityToken.toString(),
        'rawNonce': rawNonce,
      });
    } catch (exception) {
      return Result.failed(AppUnknownException(exception.toString()));
    }
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
