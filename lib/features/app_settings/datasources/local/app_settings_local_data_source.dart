import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/app_settings/business_objects/app_settings_bo.dart';

abstract class AppSettingsLocalDataSource {
  Future<void> openLockAndPasswordSettings();

  Future<Result<AppSettingsBO>> getAppSettings();

  Future<Result<AppSettingsBO>> setAppSettings(AppSettingsBO appSettingsBO);
}
