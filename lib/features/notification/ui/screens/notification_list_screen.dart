import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/notification/cubit/notifications_history_cubit.dart';
import 'package:pssn/features/notification/cubit/notifications_history_state.dart';
import 'package:pssn/features/notification/datasources/api/notifications_history_api.dart';
import 'package:pssn/features/notification/datasources/remote/default_remote_notifications_data_source.dart';
import 'package:pssn/features/notification/repository/default_notifications_history_repository.dart';

class NotificationsListScreen extends StatelessWidget {
  const NotificationsListScreen({super.key});

  static const path = 'notification-list';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsHistoryCubit>(
      create: (_) {
        final client = getIt<Dio>();
        final notificationsApi = NotificationsHistoryApi(client);
        final notificationsRemoteDatasource =
            DefaultRemoteNotificationsDataSource(notificationsApi);
        final notificationsHistoryRepository =
            DefaultNotificationsHistoryRepository(
          notificationsRemoteDatasource,
        );
        return NotificationsHistoryCubit(notificationsHistoryRepository)
          ..getNotificationsHistory();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          title: const Text('Notifications list'),
        ),
        body: const _NotificationListWidget(),
      ),
    );
  }
}

class _NotificationListWidget extends StatelessWidget {
  const _NotificationListWidget();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BlocBuilder<NotificationsHistoryCubit, NotificationsHistoryState>(
          builder: (context, state) => state.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            data: (notifications) => SliverList(
              delegate: SliverChildListDelegate(
                notifications
                    .map(
                      (notification) => ListTile(
                        leading: Text(notification.id.toString()),
                        title: Text(notification.title),
                        subtitle: Text(notification.createdAt),
                        trailing: const Icon(
                          Icons.do_not_touch,
                          color: Colors.amber,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            error: (exception) => SliverToBoxAdapter(
              child: Text(exception.message),
            ),
          ),
        ),
      ],
    );
  }
}
