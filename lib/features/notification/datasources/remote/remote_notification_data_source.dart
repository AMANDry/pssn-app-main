import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/notification/business_objects/app_notification_bo.dart';

abstract class RemoteNotificationsDataSource {
  Future<Result<bool>> initialize(String deviceToken);

  Future<Result<List<AppNotificationBO>>> getNotificationsHistory();
}
