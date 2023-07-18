import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/app_settings/repositories/app_settings_service.dart';
import 'package:pssn/features/local_auth/cubit/local_auth_state.dart';
import 'package:pssn/features/local_auth/repositories/local_auth_service.dart';

class LocalAuthCubit extends Cubit<LocalAuthState> {
  LocalAuthCubit({
    AppSettingsService? appSettingsService,
    LocalAuthService? localAuthService,
    required this.localizedReason,
  })  : _localAuthService = localAuthService ?? getIt.get(),
        _appSettingsService = appSettingsService ?? getIt.get(),
        super(const LocalAuthState.data(isAuthenticated: false)) {
    authenticate();
  }

  bool _authInProgress = false;

  final String localizedReason;
  final LocalAuthService _localAuthService;
  final AppSettingsService _appSettingsService;

  Future<void> openLockAndPasswordSettings() async {
    return _appSettingsService.openLockAndPasswordSettings();
  }

  Future<bool> authenticate({bool force = false}) async {
    bool authenticated = false;
    // If authentication is in progress return immidiately
    if (_authInProgress) {
      return authenticated;
    }

    _authInProgress = true;

    final appSettingsResult = await _appSettingsService.getAppSettings();

    // Authenticate only when biometrics settings are enabled
    await appSettingsResult.whenOrNull(
      success: (appSettings) async {
        if (force || appSettings.biometrics) {
          final localAuthResult =
              await _localAuthService.authenticate(localizedReason);

          localAuthResult.when(
            success: (authneticated) {
              emit(LocalAuthState.data(isAuthenticated: authneticated));
              authenticated = authneticated;
            },
            failed: (exception) {
              emit(LocalAuthState.error(exception));
            },
          );
        }
      },
    );

    _authInProgress = false;

    return authenticated;
  }
}
