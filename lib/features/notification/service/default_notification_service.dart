import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/notification/business_objects/remote_message.dart';
import 'package:pssn/features/notification/datasources/local/local_notification_data_source.dart';
import 'package:pssn/features/notification/datasources/remote/remote_notification_data_source.dart';
import 'package:pssn/features/notification/service/notification_service.dart';

class DefaultNotificationService implements NotificationService {
  DefaultNotificationService({
    required LocalNotificationDataSource? localNoficationDataSource,
    required RemoteNotificationsDataSource? remoteNotificationDataSource,
  })  : _localNotificationDataSource = localNoficationDataSource ?? getIt(),
        _remoteNotificationDataSource = remoteNotificationDataSource ?? getIt();

  final LocalNotificationDataSource _localNotificationDataSource;
  final RemoteNotificationsDataSource _remoteNotificationDataSource;
  late final StreamSubscription<RemoteMessage?>
      _onAppForegroundMessageSubscription;

  @override
  Future<Result<bool>> initialize() async {
    final token = await _localNotificationDataSource.deviceToken;

    if (token != null) {
      final remoteInitializationResult =
          await _remoteNotificationDataSource.initialize(token);

      final localInitializationResult =
          await _localNotificationDataSource.initialize();

      final sourcesInitialized = combine2Results(
        remoteInitializationResult,
        localInitializationResult,
      );

      sourcesInitialized.mapOrNull(
        success: (_) async {
          // Handler initial message from terminated state
          await _localNotificationDataSource.onAppOpenedTerminatedMessage;
          // Handler messages when app is opened from background state
          _localNotificationDataSource.onAppOpenedBackgroundMessage
              .listen((remoteMessage) {});
          // Hanlde foreground messages
          _onAppForegroundMessageSubscription = _localNotificationDataSource
              .onAppForegroundMessage
              .listen((remoteMessage) {
            if (remoteMessage != null) {
              _localNotificationDataSource.showLocalNotification(remoteMessage);
            }
          });
          // Handle background messages (when app is in background or terminated)
          _localNotificationDataSource.onAppBackgroundMessage =
              backgroundMessageHandler;
        },
      );

      return sourcesInitialized;
    }

    return Result.failed(AppUnknownException("Can't get device token"));
  }

  @override
  Future<void> dispose() async {
    _onAppForegroundMessageSubscription.cancel();
  }
}

// Should be top-level, named function and marked with @pragma('vm:entry-point') since Flutter 3.3.0
@pragma('vm:entry-point')
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('App is in background');
  }
}
