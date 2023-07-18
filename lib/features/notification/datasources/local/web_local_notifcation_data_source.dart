import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/app_variables.dart';
import 'package:pssn/features/notification/datasources/local/default_local_notification_data_source.dart';
import 'package:pssn/features/notification/datasources/local/local_notification_data_source.dart';

class WebLocalNotificationDataSource extends DefaultLocalNotificationDataSource
    implements LocalNotificationDataSource {
  WebLocalNotificationDataSource({
    required super.firebaseMessaging,
    required super.localNotificationsPlugin,
  }) : _firebaseMessaging = firebaseMessaging ?? getIt();

  final FirebaseMessaging _firebaseMessaging;

  @override
  Future<String?> get deviceToken =>
      _firebaseMessaging.getToken(vapidKey: AppCompileTimeVars.vapidKey);

  @override
  Future<Result<bool>> initialize() async {
    return const Result.success(true);
  }

  @override
  void noSuchMethod(Invocation invocation) {
    super.noSuchMethod(invocation);
  }
}
