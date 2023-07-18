import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/app_settings/business_objects/app_settings_bo.dart';
import 'package:pssn/features/app_settings/datasources/local/app_settings_local_data_source.dart';

abstract class AppSettingsService {
  Future<void> openLockAndPasswordSettings();
  Future<Result<AppSettingsBO>> getAppSettings();
  Future<Result<AppSettingsBO>> setAppSettings(AppSettingsBO appSettingsBO);
}

class DefaultAppSettingsService implements AppSettingsService {
  DefaultAppSettingsService({
    required AppSettingsLocalDataSource? localDataSource,
  }) : _appSettingsLocalDataSource = localDataSource ?? getIt();

  final AppSettingsLocalDataSource _appSettingsLocalDataSource;

  @override
  Future<void> openLockAndPasswordSettings() {
    return _appSettingsLocalDataSource.openLockAndPasswordSettings();
  }

  @override
  Future<Result<AppSettingsBO>> getAppSettings() {
    return _appSettingsLocalDataSource.getAppSettings();
  }

  @override
  Future<Result<AppSettingsBO>> setAppSettings(AppSettingsBO appSettingsBO) {
    return _appSettingsLocalDataSource.setAppSettings(appSettingsBO);
  }
}
