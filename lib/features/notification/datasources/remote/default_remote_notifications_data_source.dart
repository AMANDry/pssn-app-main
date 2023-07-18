import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/extensions.dart';
import 'package:pssn/features/notification/business_objects/app_notification_bo.dart';
import 'package:pssn/features/notification/datasources/api/notifications_history_api.dart';
import 'package:pssn/features/notification/datasources/remote/remote_notification_data_source.dart';

class DefaultRemoteNotificationsDataSource
    extends RemoteNotificationsDataSource {
  DefaultRemoteNotificationsDataSource(
    NotificationsHistoryApi? notificationsHistoryApi,
  ) : _notificationsHistoryApi = notificationsHistoryApi ?? getIt();

  final NotificationsHistoryApi _notificationsHistoryApi;

  @override
  Future<Result<bool>> initialize(String deviceToken) async {
    return _notificationsHistoryApi.updateToken(deviceToken).toResult<bool>();
  }

  @override
  Future<Result<List<AppNotificationBO>>> getNotificationsHistory() {
    return _notificationsHistoryApi.getNotificationsHistory().toResult(
          mapper: (notifications) =>
              notifications.map((notification) => notification.toBo()).toList(),
        );
  }
}
