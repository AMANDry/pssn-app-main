import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/features/app_settings/business_objects/app_settings_bo.dart';
import 'package:pssn/features/app_settings/cubit/app_settings_cubit.dart';
import 'package:pssn/features/app_settings/cubit/app_settings_state.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage();

  static const path = 'settings-notifications';

  @override
  State<StatefulWidget> createState() => _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (_, state) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Notifications'),
        ),
        body: ListView(
          children: state.when(
            data: (AppSettingsBO appSettings) {
              return [
                ListTile(
                  leading: const Icon(Icons.notifications_none),
                  title: const Text('Important'),
                  trailing: Switch(
                    value: appSettings.importantNotifications,
                    onChanged: (bool value) {
                      context.read<AppSettingsCubit>().setAppSettings(
                            appSettings.copyWith(importantNotifications: value),
                          );
                    },
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.notifications_active),
                  title: const Text('General'),
                  trailing: Switch(
                    value: appSettings.generalNotifications,
                    onChanged: (bool value) {
                      context.read<AppSettingsCubit>().setAppSettings(
                            appSettings.copyWith(generalNotifications: value),
                          );
                    },
                  ),
                ),
                const Divider(),
              ];
            },
            loading: () {
              return [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              ];
            },
            error: (_) => [const SizedBox.shrink()],
          ),
        ),
      ),
    );
  }
}
