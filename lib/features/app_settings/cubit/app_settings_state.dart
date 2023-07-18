import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/app_settings/business_objects/app_settings_bo.dart';

part 'app_settings_state.freezed.dart';

@freezed
class AppSettingsState with _$AppSettingsState {
  const factory AppSettingsState.loading() = _Loading;
  const factory AppSettingsState.data(AppSettingsBO appSettings) = _Data;
  const factory AppSettingsState.error(AppException error) = _Error;
}
