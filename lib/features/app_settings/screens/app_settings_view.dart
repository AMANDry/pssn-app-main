import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pssn/features/app_settings/screens/about_settings_screen.dart';
import 'package:pssn/features/app_settings/screens/notifications_settings_screen.dart';
import 'package:pssn/features/app_settings/screens/security_settings_screen.dart';
import 'package:pssn/features/profile/screens/profile_page.dart';

class AppSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Divider(),
        ListTile(
          leading: const Icon(Icons.security),
          title: const Text('Security'),
          onTap: () {
            GoRouter.of(context)
                .go('${ProfilePage.path}/${SecuritySettingsPage.path}');
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          onTap: () {
            GoRouter.of(context)
                .go('${ProfilePage.path}/${NotificationsSettingsPage.path}');
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.question_answer),
          title: const Text('About'),
          onTap: () {
            GoRouter.of(context)
                .go('${ProfilePage.path}/${AboutSettingsPage.path}');
          },
        ),
        const Divider(),
      ],
    );
  }
}
