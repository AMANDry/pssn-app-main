import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/profile/business_objects/profile_bo.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.data(ProfileBO data) = _Data;
  const factory ProfileState.error(AppException error) = _Error;
}
