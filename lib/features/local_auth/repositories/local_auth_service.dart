import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/local_auth/datasources/local/local_auth_local_data_source.dart';

abstract class LocalAuthService {
  Future<Result<bool>> authenticate(String localizedReason);
}

class DefaultLocalAuthService implements LocalAuthService {
  DefaultLocalAuthService({
    required LocalAuthLocalDataSource? localDataSource,
  }) : _localAuthLocalDataSource = localDataSource ?? getIt();

  final LocalAuthLocalDataSource _localAuthLocalDataSource;

  @override
  Future<Result<bool>> authenticate(String localizedReason) {
    return _localAuthLocalDataSource.authenticate(localizedReason);
  }
}
