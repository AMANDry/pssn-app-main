import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';

part 'push_notifications_state.freezed.dart';

@freezed
class PushNotificationsState with _$PushNotificationsState {
  const factory PushNotificationsState.loading() = _Loading;
  const factory PushNotificationsState.data() = _Data;
  const factory PushNotificationsState.error(AppException exception) = _Error;
}
