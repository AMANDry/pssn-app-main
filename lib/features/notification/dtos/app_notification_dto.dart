import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/notification/business_objects/app_notification_bo.dart';

part 'app_notification_dto.freezed.dart';
part 'app_notification_dto.g.dart';

@freezed
class AppNotificationDTO with _$AppNotificationDTO {
  const factory AppNotificationDTO({
    @Default(0) int id,
    @Default('Unknown') String title,
    @Default('Unknown') String createdAt,
  }) = _AppNotificationDTO;

  const AppNotificationDTO._();

  AppNotificationBO toBo() =>
      AppNotificationBO(id: id, title: title, createdAt: createdAt);

  factory AppNotificationDTO.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationDTOFromJson(json);
}
