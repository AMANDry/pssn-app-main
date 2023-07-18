import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/digital_id/business_objects/digital_id_bo.dart';

part 'digital_id_state.freezed.dart';

@freezed
class DigitalIdState with _$DigitalIdState {
  const factory DigitalIdState.loading() = _Loading;
  const factory DigitalIdState.data(DigitalIdBO data) = _Data;
  const factory DigitalIdState.error(AppException error) = _Error;
}
