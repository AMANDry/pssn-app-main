import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/common/helpers/app_variables.dart';
import 'package:pssn/features/notification/datasources/local/default_local_notification_data_source.dart';

import 'package:pssn/features/notification/datasources/local/local_notification_data_source.dart';

class AndroidLocalNotificationDataSource
    extends DefaultLocalNotificationDataSource
    implements LocalNotificationDataSource {
  AndroidLocalNotificationDataSource({
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

  final AndroidNotificationChannel _notificationChannel =
      const AndroidNotificationChannel(
    AppRuntimeVars.defaultChannelId,
    AppRuntimeVars.defaultChannelName,
    importance: Importance.max,
  );

  @override
  Future<Result<bool>> initialize() async {
    try {
      const AndroidInitializationSettings androidInitializationSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings initializationSettings =
          InitializationSettings(android: androidInitializationSettings);

      final initializationResult = await _localNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            _onDidReceiveBackgroundNotificationResponse,
      );

      if (initializationResult ?? false) {
        await _localNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(_notificationChannel);
      }

      return Result.success(initializationResult ?? false);
    } on Exception catch (exception) {
      return Result.failed(
        AppUnknownException(exception.toString()),
      );
    }
  }
}
