import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/notification/business_objects/app_notification_bo.dart';
import 'package:pssn/features/notification/datasources/remote/remote_notification_data_source.dart';
import 'package:pssn/features/notification/repository/notifications_history_repository.dart';

class DefaultNotificationsHistoryRepository
    extends NotificationsHistoryRepository {
  DefaultNotificationsHistoryRepository(
    RemoteNotificationsDataSource? notificationRemoteDataSource,
  ) : _remoteNotificationsDataSource = notificationRemoteDataSource ?? getIt();

  final RemoteNotificationsDataSource _remoteNotificationsDataSource;

  @override
  Future<Result<List<AppNotificationBO>>> getNotificationsHistory() {
    return _remoteNotificationsDataSource.getNotificationsHistory();
  }
}
