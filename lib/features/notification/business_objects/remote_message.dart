import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_message.freezed.dart';

@freezed
class RemoteMessage with _$RemoteMessage {
  const factory RemoteMessage({
    int? ttl,
    String? from,
    String? threadId,
    String? senderId,
    String? category,
    String? messageId,
    String? messageType,
    String? collapseKey,
    DateTime? sentTime,
    RemoteNotification? notification,
    @Default(false) bool mutableContent,
    @Default(false) bool contentAvailable,
    @Default(<String, dynamic>{}) Map<String, dynamic> data,
  }) = _RemoteMessage;
}

@freezed
class RemoteNotification with _$RemoteNotification {
  const factory RemoteNotification({
    String? body,
    String? title,
    String? bodyLocKey,
    String? titleLocKey,
    WebNotification? web,
    AppleNotification? apple,
    AndroidNotification? android,
    @Default(<String>[]) List<String> bodyLocArgs,
    @Default(<String>[]) List<String> titleLocArgs,
  }) = _RemoteNotification;
}

@freezed
class AndroidNotification with _$AndroidNotification {
  const factory AndroidNotification({
    int? count,
    String? tag,
    String? link,
    String? color,
    String? sound,
    String? ticker,
    String? imageUrl,
    String? channelId,
    String? smallIcon,
    String? clickAction,
    @Default(AndroidNotificationPriority.defaultPriority)
        AndroidNotificationPriority priority,
    @Default(AndroidNotificationVisibility.private)
        AndroidNotificationVisibility visibility,
  }) = _AndroidNotification;
}

enum AndroidNotificationPriority {
  minimumPriority,
  lowPriority,
  defaultPriority,
  highPriority,
  maximumPriority,
}

enum AndroidNotificationVisibility { secret, private, public }

@freezed
class AppleNotification with _$AppleNotification {
  const factory AppleNotification({
    String? badge,
    String? imageUrl,
    String? subtitle,
    String? subtitleLocKey,
    @Default(<String>[]) List<String> subtitleLocArgs,
    AppleNotificationSound? sound,
  }) = _AppleNotification;
}

@freezed
class AppleNotificationSound with _$AppleNotificationSound {
  const factory AppleNotificationSound({
    String? name,
    @Default(0) num volume,
    @Default(false) bool critical,
  }) = _AppleNotificationSound;
}

@freezed
class WebNotification with _$WebNotification {
  const factory WebNotification({
    String? link,
    String? image,
    String? analyticsLabel,
  }) = _WebNotification;
}
