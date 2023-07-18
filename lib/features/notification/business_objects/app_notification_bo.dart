import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification_bo.freezed.dart';

@freezed
class AppNotificationBO with _$AppNotificationBO {
  const factory AppNotificationBO({
    required int id,
    required String title,
    required String createdAt,
  }) = _AppNotificationBO;
}
