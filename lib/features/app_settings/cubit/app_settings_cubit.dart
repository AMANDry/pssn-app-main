import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/app_settings/business_objects/app_settings_bo.dart';
import 'package:pssn/features/app_settings/cubit/app_settings_state.dart';
import 'package:pssn/features/app_settings/repositories/app_settings_service.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit(AppSettingsService? appSettingsService)
      : _appSettingsService = appSettingsService ?? getIt.get(),
        super(const AppSettingsState.loading()) {
    getAppSettings();
  }

  final AppSettingsService _appSettingsService;

  Future<void> openLockAndPasswordSettings() async {
    return _appSettingsService.openLockAndPasswordSettings();
  }

  Future<void> getAppSettings() async {
    emit(const AppSettingsState.loading());

    await Future<void>.delayed(const Duration(seconds: 1));

    final result = await _appSettingsService.getAppSettings();

    emit(
      result.when(
        success: AppSettingsState.data,
        failed: AppSettingsState.error,
      ),
    );
  }

  Future<void> setAppSettings(AppSettingsBO appSettingsBO) async {
    emit(const AppSettingsState.loading());

    final result = await _appSettingsService.setAppSettings(appSettingsBO);

    emit(
      result.when(
        success: AppSettingsState.data,
        failed: AppSettingsState.error,
      ),
    );
  }
}
