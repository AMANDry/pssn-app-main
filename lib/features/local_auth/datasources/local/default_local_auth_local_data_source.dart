import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/local_auth/datasources/local/local_auth_local_data_source.dart';
import 'package:pssn/features/local_auth/exceptions/exceptions.dart';

class DefaultLocalAuthLocalDataSource implements LocalAuthLocalDataSource {
  DefaultLocalAuthLocalDataSource(LocalAuthentication? localAuthentication)
      : _localAuthentication = localAuthentication ?? getIt();

  final LocalAuthentication _localAuthentication;

  @override
  Future<Result<bool>> authenticate(String localizedReason) async {
    try {
      final result = await _localAuthentication.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(useErrorDialogs: false),
      );

      return Result.success(result);
    } on PlatformException catch (exception) {
      return Result.failed(
        AppLocalAuthException(exception.message ?? 'Unknown', exception.code),
      );
    }
  }
}
