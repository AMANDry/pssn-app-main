import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/app_lifecycle_observer.dart';
import 'package:pssn/common/widgets/app_bottom_navigation_bar.dart';
import 'package:pssn/features/app_settings/cubit/app_settings_cubit.dart';
import 'package:pssn/features/app_settings/cubit/app_settings_state.dart';
import 'package:pssn/features/app_settings/datasources/local/default_app_settings_local_data_source.dart';
import 'package:pssn/features/app_settings/repositories/app_settings_service.dart';
import 'package:pssn/features/local_auth/cubit/local_auth_cubit.dart';
import 'package:pssn/features/local_auth/cubit/local_auth_state.dart';
import 'package:pssn/features/local_auth/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late final AppLifecycleObserver lifecycleObserver;
  @override
  void initState() {
    super.initState();

    lifecycleObserver = AppLifecycleObserver(
      onResumed: () async {
        final localAuthCubit = context.read<LocalAuthCubit>();
        localAuthCubit.state.whenOrNull(
          error: (exception) {
            if (exception is AppLocalAuthException) {
              switch (exception.code) {
                case AppLocalAuthException.notEnrolled:
                case AppLocalAuthException.passcodeNotSet:
                  localAuthCubit.authenticate();
                  break;
                // Different behavior on iOS and Android
                case AppLocalAuthException.notAvailable:
                  {
                    if (Platform.isAndroid) {
                      localAuthCubit.authenticate();
                    }
                  }
              }
            }
          },
        );
      },
    );

    WidgetsBinding.instance.addObserver(lifecycleObserver);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppSettingsCubit>(
      create: (_) {
        final sharedPreferences = getIt<SharedPreferences>();

        final localAppSettingsDataSource =
            DefaultAppSettingsLocalDataSource(sharedPreferences);

        final appSettingsService = DefaultAppSettingsService(
          localDataSource: localAppSettingsDataSource,
        );

        return AppSettingsCubit(appSettingsService);
      },
      child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (_, appSettingsState) {
          return BlocBuilder<LocalAuthCubit, LocalAuthState>(
            builder: (_, localAuthState) {
              return Scaffold(
                body: SafeArea(
                  child: appSettingsState.when(
                    loading: () => widget.child,
                    data: (appSettings) {
                      return Column(
                        children: [
                          if (appSettings.biometrics)
                            localAuthState.when(
                              loading: () => const SizedBox.shrink(),
                              data: (isAuthenticated) {
                                return isAuthenticated
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Text('Local authentication: '),
                                          Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                        ],
                                      )
                                    : const _AuthenticateButton();
                              },
                              error: (exception) {
                                // Open phone setting if no authentication (screen lock) is set
                                if (exception is AppLocalAuthException) {
                                  switch (exception.code) {
                                    case AppLocalAuthException.notEnrolled:
                                    case AppLocalAuthException.passcodeNotSet:
                                      {
                                        return ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<LocalAuthCubit>()
                                                .openLockAndPasswordSettings();
                                          },
                                          child: const _OpenSettingsButton(),
                                        );
                                      }
                                    // Different behavior on iOS and Android
                                    case AppLocalAuthException.notAvailable:
                                      {
                                        if (Platform.isIOS) {
                                          return const _AuthenticateButton();
                                        } else if (Platform.isAndroid) {
                                          return const _OpenSettingsButton();
                                        }
                                      }
                                  }
                                }
                                return const Text('Error');
                              },
                            ),
                          Expanded(child: widget.child)
                        ],
                      );
                    },
                    error: (_) => const SizedBox.shrink(),
                  ),
                ),
                bottomNavigationBar: const AppBottomNavigationBar(),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(lifecycleObserver);
    super.dispose();
  }
}

class _OpenSettingsButton extends StatelessWidget {
  const _OpenSettingsButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text('Open settings'),
        SizedBox(width: 10),
        Icon(Icons.settings)
      ],
    );
  }
}

class _AuthenticateButton extends StatelessWidget {
  const _AuthenticateButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<LocalAuthCubit>().authenticate();
      },
      child: const Text('Authenticate'),
    );
  }
}
