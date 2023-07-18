import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/journey/business_objects/journey_bo.dart';

part 'journey_state.freezed.dart';

@freezed
class JourneyState with _$JourneyState {
  const factory JourneyState.loading() = _Loading;
  const factory JourneyState.data(JourneyBO data) = _Data;
  const factory JourneyState.error(AppException error) = _Error;
}
