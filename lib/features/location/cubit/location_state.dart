import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/location/business_objects/location_bo.dart';

part 'location_state.freezed.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.loading() = _Loading;
  const factory LocationState.data(LocationBO data) = _Data;
  const factory LocationState.error(AppException error) = _Error;
}
