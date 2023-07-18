import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/notification/business_objects/remote_message.dart';

abstract class LocalNotificationDataSource {
  Future<Result<bool>> initialize();

  Future<void> showLocalNotification(RemoteMessage remoteMessage);

  Future<void> removeLocalNotification(int id);

  Future<String?> get deviceToken;

  Stream<RemoteMessage?> get onAppForegroundMessage;

  // ignore: avoid_setters_without_getters
  set onAppBackgroundMessage(Future<void> Function(RemoteMessage) hanlder);

  Stream<RemoteMessage?> get onAppOpenedBackgroundMessage;

  Future<RemoteMessage?> get onAppOpenedTerminatedMessage;
}
