import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';

part 'local_auth_state.freezed.dart';

@freezed
class LocalAuthState with _$LocalAuthState {
  const factory LocalAuthState.loading() = _Loading;
  const factory LocalAuthState.data({@Default(false) bool isAuthenticated}) =
      _Data;
  const factory LocalAuthState.error(AppException error) = Error;
}
