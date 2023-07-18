import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/app_variables.dart';
import 'package:pssn/common/helpers/logging_mixin.dart';
import 'package:pssn/features/notification/business_objects/remote_message.dart'
    as bo;

typedef OnNotificationClickedCallback = void Function(NotificationResponse)?;

class DefaultLocalNotificationDataSource with AppLoggingMixin {
  DefaultLocalNotificationDataSource({
    required FirebaseMessaging? firebaseMessaging,
    required FlutterLocalNotificationsPlugin? localNotificationsPlugin,
  })  : _firebaseMessaging = firebaseMessaging ?? getIt(),
        _localNotificationsPlugin = localNotificationsPlugin ?? getIt();

  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;

  Future<String?> get deviceToken => _firebaseMessaging.getToken();

  // Initial message when app was opened from terminated state
  Future<bo.RemoteMessage?> get onAppOpenedTerminatedMessage async {
    final remoteMessage = await _firebaseMessaging.getInitialMessage();
    printInfo('App was opened from terminated state');
    return remoteMessage?.toBO();
  }

  // Message received when app is in foreground
  Stream<bo.RemoteMessage> get onAppForegroundMessage {
    return _firebaseMessaging.onAppForegroundMessage
        .map((RemoteMessage remoteMessage) {
      printInfo('App is in foreground');
      return remoteMessage.toBO();
    });
  }

  // Message received when app was opened from background
  Stream<bo.RemoteMessage?> get onAppOpenedBackgroundMessage {
    return _firebaseMessaging.onAppOpenedBackgroundMessage
        .map((RemoteMessage remoteMessage) {
      printInfo('App was opened from background state');
      return remoteMessage.toBO();
    });
  }

  // ignore: avoid_setters_without_getters
  set onAppBackgroundMessage(Future<void> Function(bo.RemoteMessage) hanlder) {
    _firebaseMessaging.onAppBackgroundMessage = hanlder;
  }

  Future<void> showLocalNotification(bo.RemoteMessage remoteMessage) async {
    _localNotificationsPlugin.show(
      remoteMessage.hashCode,
      remoteMessage.notification?.title ?? '',
      remoteMessage.notification?.body ?? '',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          AppRuntimeVars.defaultChannelId,
          AppRuntimeVars.defaultChannelName,
        ),
      ),
      payload: remoteMessage.data.toString(),
    );
  }

  Future<void> removeLocalNotification(int id) {
    return _localNotificationsPlugin.cancel(id);
  }
}

extension on FirebaseMessaging {
  Stream<RemoteMessage> get onAppForegroundMessage =>
      FirebaseMessaging.onMessage;

  Stream<RemoteMessage> get onAppOpenedBackgroundMessage =>
      FirebaseMessaging.onMessageOpenedApp;

  set onAppBackgroundMessage(Future<void> Function(bo.RemoteMessage) handler) {
    _onAppBackgroundMessage = handler;
    FirebaseMessaging.onBackgroundMessage(_onFirebaseBackgroundMessage);
  }
}

Future<void> Function(bo.RemoteMessage)? _onAppBackgroundMessage;

Future<void> _onFirebaseBackgroundMessage(RemoteMessage message) async {
  _onAppBackgroundMessage?.call(message.toBO());
}

extension on RemoteMessage {
  bo.RemoteMessage toBO() {
    return bo.RemoteMessage(
      ttl: ttl,
      data: data,
      from: from,
      senderId: senderId,
      category: category,
      sentTime: sentTime,
      threadId: threadId,
      messageId: messageId,
      messageType: messageType,
      collapseKey: collapseKey,
      mutableContent: mutableContent,
      contentAvailable: contentAvailable,
      notification: bo.RemoteNotification(
        body: notification?.body,
        title: notification?.title,
        bodyLocKey: notification?.bodyLocKey,
        titleLocKey: notification?.titleLocKey,
        bodyLocArgs: notification?.bodyLocArgs ?? [],
        titleLocArgs: notification?.titleLocArgs ?? [],
        web: bo.WebNotification(
          link: notification?.web?.link,
          image: notification?.web?.image,
          analyticsLabel: notification?.web?.analyticsLabel,
        ),
        apple: bo.AppleNotification(
          badge: notification?.apple?.badge,
          imageUrl: notification?.apple?.imageUrl,
          subtitle: notification?.apple?.subtitle,
          subtitleLocKey: notification?.apple?.subtitleLocKey,
          subtitleLocArgs: notification?.apple?.subtitleLocArgs ?? [],
          sound: bo.AppleNotificationSound(
            name: notification?.apple?.sound?.name,
            volume: notification?.apple?.sound?.volume ?? 0,
            critical: notification?.apple?.sound?.critical ?? false,
          ),
        ),
        android: bo.AndroidNotification(
          tag: notification?.android?.tag,
          link: notification?.android?.link,
          color: notification?.android?.color,
          sound: notification?.android?.sound,
          count: notification?.android?.count,
          ticker: notification?.android?.ticker,
          imageUrl: notification?.android?.imageUrl,
          channelId: notification?.android?.channelId,
          smallIcon: notification?.android?.smallIcon,
          clickAction: notification?.android?.clickAction,
          priority: bo.AndroidNotificationPriority
              .values[notification?.android?.priority.index ?? 2],
          visibility: bo.AndroidNotificationVisibility
              .values[notification?.android?.visibility.index ?? 1],
        ),
      ),
    );
  }
}
