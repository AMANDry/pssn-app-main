import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/notification/business_objects/app_notification_bo.dart';

abstract class NotificationsHistoryRepository {
  Future<Result<List<AppNotificationBO>>> getNotificationsHistory();
}
