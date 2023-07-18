import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/notification/cubit/push_notifications_state.dart';
import 'package:pssn/features/notification/service/notification_service.dart';

class PushNotificationsCubit extends Cubit<PushNotificationsState> {
  PushNotificationsCubit({
    required NotificationService? notificationService,
  })  : _notificationService = notificationService ?? getIt(),
        super(const PushNotificationsState.loading());

  final NotificationService _notificationService;

  Future<void> initialize() async {
    final result = await _notificationService.initialize();

    final state = result.when(
      success: (_) => const PushNotificationsState.data(),
      failed: (exception) => PushNotificationsState.error(exception),
    );

    emit(state);
  }

  @override
  Future<void> close() async {
    await _notificationService.dispose();
    return super.close();
  }
}
