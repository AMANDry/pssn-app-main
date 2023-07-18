import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.loading() = _Loading;
  const factory SignInState.data() = _Data;
  const factory SignInState.error(AppException error) = _Error;
}
