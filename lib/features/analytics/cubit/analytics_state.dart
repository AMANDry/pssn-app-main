import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';

part 'analytics_state.freezed.dart';

@freezed
class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState.loading() = _Loading;
  const factory AnalyticsState.data() = _Data;
  const factory AnalyticsState.error(AppException error) = _Error;
}
