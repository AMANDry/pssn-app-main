import 'package:dio/dio.dart';
import 'package:pssn/features/notification/dtos/app_notification_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'notifications_history_api.g.dart';

@RestApi()
abstract class NotificationsHistoryApi {
  factory NotificationsHistoryApi(Dio client) = _NotificationsHistoryApi;

  @GET('/notification/history')
  Future<List<AppNotificationDTO>> getNotificationsHistory();

  @POST('/notification/token')
  Future<bool> updateToken(@Body() String token);
}
