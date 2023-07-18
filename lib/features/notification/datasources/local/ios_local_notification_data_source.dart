import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/notification/datasources/local/default_local_notification_data_source.dart';
import 'package:pssn/features/notification/datasources/local/local_notification_data_source.dart';

class IOSLocalNotificationDataSource extends DefaultLocalNotificationDataSource
    implements LocalNotificationDataSource {
  IOSLocalNotificationDataSource({
    required super.firebaseMessaging,
    required super.localNotificationsPlugin,
    OnNotificationClickedCallback onDidReceiveNotificationResponse,
    OnNotificationClickedCallback onDidReceiveBackgroundNotificationResponse,
  })  : _localNotificationsPlugin = localNotificationsPlugin ?? getIt(),
        _onDidReceiveNotificationResponse = onDidReceiveNotificationResponse,
        _onDidReceiveBackgroundNotificationResponse =
            onDidReceiveBackgroundNotificationResponse;

  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  final OnNotificationClickedCallback _onDidReceiveNotificationResponse;
  final OnNotificationClickedCallback
      _onDidReceiveBackgroundNotificationResponse;

  @override
  Future<Result<bool>> initialize() async {
    const DarwinInitializationSettings iOSinitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(iOS: iOSinitializationSettings);

    final initializationResult = await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveBackgroundNotificationResponse,
    );

    return Result.success(initializationResult ?? false);
  }
}
