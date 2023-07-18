import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/notification/business_objects/app_notification_bo.dart';

part 'notifications_history_state.freezed.dart';

@freezed
class NotificationsHistoryState with _$NotificationsHistoryState {
  const factory NotificationsHistoryState.loading() = _Loading;
  const factory NotificationsHistoryState.data(List<AppNotificationBO> notifications) =
      _Data;
  const factory NotificationsHistoryState.error(AppException exception) =
      _Error;
}
