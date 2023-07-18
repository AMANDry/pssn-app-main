import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings_bo.freezed.dart';

@freezed
class AppSettingsBO with _$AppSettingsBO {
  const factory AppSettingsBO({
    required bool biometrics,
    required bool generalNotifications,
    required bool importantNotifications,
  }) = _AppSettingsBO;
}
