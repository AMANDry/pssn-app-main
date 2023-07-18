import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/notification/cubit/notifications_history_state.dart';
import 'package:pssn/features/notification/repository/notifications_history_repository.dart';

class NotificationsHistoryCubit extends Cubit<NotificationsHistoryState> {
  NotificationsHistoryCubit(
    NotificationsHistoryRepository? notificationHistoryRepository,
  )   : _notificationHistoryRepository =
            notificationHistoryRepository ?? getIt(),
        super(const NotificationsHistoryState.loading());

  final NotificationsHistoryRepository _notificationHistoryRepository;

  Future<void> getNotificationsHistory() async {
    final result =
        await _notificationHistoryRepository.getNotificationsHistory();

    final state = result.when(
      success: (notificationsList) =>
          NotificationsHistoryState.data(notificationsList),
      failed: (exception) => NotificationsHistoryState.error(exception),
    );

    emit(state);
  }
}
