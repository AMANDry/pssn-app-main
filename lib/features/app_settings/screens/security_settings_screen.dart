import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/features/app_settings/business_objects/app_settings_bo.dart';
import 'package:pssn/features/app_settings/cubit/app_settings_cubit.dart';
import 'package:pssn/features/app_settings/cubit/app_settings_state.dart';
import 'package:pssn/features/local_auth/cubit/local_auth_cubit.dart';

class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage();

  static const path = 'settings-security';

  @override
  State<StatefulWidget> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (_, appSettingsState) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Security'),
        ),
        body: ListView(
          children: [
            appSettingsState.when(
              data: (AppSettingsBO appSettings) {
                return ListTile(
                  leading: const Icon(Icons.face),
                  title: const Text('Biometrics'),
                  trailing: Switch(
                    value: appSettings.biometrics,
                    onChanged: (bool value) async {
                      if (value) {
                        final authenticated = await context
                            .read<LocalAuthCubit>()
                            .authenticate(force: true);

                        if (authenticated) {
                          // ignore: use_build_context_synchronously
                          context.read<AppSettingsCubit>().setAppSettings(
                                appSettings.copyWith(biometrics: value),
                              );
                        }
                      } else {
                        context.read<AppSettingsCubit>().setAppSettings(
                              appSettings.copyWith(biometrics: value),
                            );
                      }
                    },
                  ),
                );
              },
              loading: () {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              },
              error: (_) => const SizedBox.shrink(),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.password),
              title: Text('Change password'),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
