import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';

part 'verification_state.freezed.dart';

@freezed
class VerificationState with _$VerificationState {
  const factory VerificationState.loading() = _Loading;
  const factory VerificationState.data({@Default(false) bool isVerified}) = Data;
  const factory VerificationState.error(AppException error) = _Error;
}
