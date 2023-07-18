import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/sign_in/business_objects/credential.dart';
import 'package:pssn/features/sign_in/datasources/remote/credential_remote_data_source.dart';

abstract class SignInService {
  Future<Result<Map<String, String>>> getCredentials(
    Credential credential, [
    Map<String, String>? data,
  ]);
}

class DefaultSignInService implements SignInService {
  DefaultSignInService({
    required Map<Credential, CredentialRemoteDataSource>? credentialDataSources,
  }) : _credentialDataSources = credentialDataSources ?? getIt();
  final Map<Credential, CredentialRemoteDataSource> _credentialDataSources;

  @override
  Future<Result<Map<String, String>>> getCredentials(
    Credential credential, [
    Map<String, String>? data,
  ]) =>
      _credentialDataSources[credential]?.getCredentials(data) ??
      Future.value(
        Result.failed(
          AppUnknownException('Unsupported credential $credential'),
        ),
      );
}
