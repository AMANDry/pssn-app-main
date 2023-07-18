import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.loading() = _Loading;
  const factory SignUpState.data() = _Data;
  const factory SignUpState.error(AppException error) = _Error;
}
