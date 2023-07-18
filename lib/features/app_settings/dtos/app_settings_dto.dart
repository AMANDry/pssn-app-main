import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/app_settings/business_objects/app_settings_bo.dart';

part 'app_settings_dto.freezed.dart';
part 'app_settings_dto.g.dart';

@freezed
class AppSettingsDTO with _$AppSettingsDTO {
  const factory AppSettingsDTO({
    @Default(false) bool biometrics,
    @Default(false) bool generalNotifications,
    @Default(false) bool importantNotifications,
  }) = _AppSettingsDTO;

  const AppSettingsDTO._();

  AppSettingsBO toBo() => AppSettingsBO(
        biometrics: biometrics,
        generalNotifications: generalNotifications,
        importantNotifications: importantNotifications,
      );

  factory AppSettingsDTO.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsDTOFromJson(json);

  factory AppSettingsDTO.fromBO(AppSettingsBO appSettingsBO) {
    return AppSettingsDTO(
      biometrics: appSettingsBO.biometrics,
      generalNotifications: appSettingsBO.generalNotifications,
      importantNotifications: appSettingsBO.importantNotifications,
    );
  }
}
