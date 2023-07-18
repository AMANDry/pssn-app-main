import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/app_settings/business_objects/app_settings_bo.dart';
import 'package:pssn/features/app_settings/datasources/local/app_settings_local_data_source.dart';
import 'package:pssn/features/app_settings/dtos/app_settings_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefaultAppSettingsLocalDataSource implements AppSettingsLocalDataSource {
  DefaultAppSettingsLocalDataSource(SharedPreferences? sharedPreferences)
      : _sharedPreferences = sharedPreferences ?? getIt();

  final _appSettingsKey = 'app-settings';
  final SharedPreferences _sharedPreferences;

  @override
  Future<void> openLockAndPasswordSettings() {
    return AppSettings.openLockAndPasswordSettings();
  }

  @override
  Future<Result<AppSettingsBO>> getAppSettings() async {
    try {
      final appSettingsJsonString =
          _sharedPreferences.getString(_appSettingsKey);
      if (appSettingsJsonString != null) {
        final appSettingsJson =
            jsonDecode(appSettingsJsonString) as Map<String, dynamic>;
        final appSettingsDTO = AppSettingsDTO.fromJson(appSettingsJson);

        return Result<AppSettingsBO>.success(appSettingsDTO.toBo());
      }
      return Result<AppSettingsBO>.success(const AppSettingsDTO().toBo());
    } catch (e) {
      return Result<AppSettingsBO>.failed(AppUnknownException(e.toString()));
    }
  }

  @override
  Future<Result<AppSettingsBO>> setAppSettings(
    AppSettingsBO appSettingsBO,
  ) async {
    try {
      final appSettingsDTO = AppSettingsDTO.fromBO(appSettingsBO);
      final appSettingsDTOJson = appSettingsDTO.toJson();
      final appSettingsDTOJsonString = jsonEncode(appSettingsDTOJson);
      
      await _sharedPreferences.setString(
        _appSettingsKey,
        appSettingsDTOJsonString,
      );

      return Result<AppSettingsBO>.success(appSettingsBO);
    } catch (e) {
      return Result<AppSettingsBO>.failed(AppUnknownException(e.toString()));
    }
  }
}
