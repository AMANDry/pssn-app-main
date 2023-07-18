import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/navigation/analytics_observer.dart';
import 'package:pssn/common/theme/app_theme.dart';
import 'package:pssn/features/analytics/repositories/analytics_service.dart';
import 'package:pssn/features/app_settings/datasources/local/default_app_settings_local_data_source.dart';
import 'package:pssn/features/app_settings/repositories/app_settings_service.dart';
import 'package:pssn/features/app_settings/screens/about_settings_screen.dart';
import 'package:pssn/features/app_settings/screens/notifications_settings_screen.dart';
import 'package:pssn/features/app_settings/screens/security_settings_screen.dart';
import 'package:pssn/features/audio_player/screens/audio_player_page.dart';
import 'package:pssn/features/authorization/repositories/authorization_service.dart';
import 'package:pssn/features/digital_id/screens/digital_id_page.dart';
import 'package:pssn/features/home/home_page.dart';
import 'package:pssn/features/journey/screens/journey_page.dart';
import 'package:pssn/features/local_auth/cubit/local_auth_cubit.dart';
import 'package:pssn/features/local_auth/datasources/local/default_local_auth_local_data_source.dart';
import 'package:pssn/features/local_auth/repositories/local_auth_service.dart';
import 'package:pssn/features/location/screens/location_page.dart';
import 'package:pssn/features/main/screens/main_page.dart';
import 'package:pssn/features/notification/ui/screens/notification_list_screen.dart';
import 'package:pssn/features/profile/screens/profile_page.dart';
import 'package:pssn/features/sign_in/screens/sign_in_page.dart';
import 'package:pssn/features/sign_up/screens/sign_up_page.dart';
import 'package:pssn/features/verification/screens/verification_page.dart';
import 'package:pssn/features/video_player/screens/video_player_page.dart';
import 'package:pssn/features/visit_requests/screens/visit_requests_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<StatefulWidget> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  GoRoute _goRoute({
    required String path,
    required Widget page,
    List<RouteBase> routes = const [],
  }) =>
      GoRoute(
        path: path,
        pageBuilder: (context, state) => CustomTransitionPage<StatelessWidget>(
          key: state.pageKey,
          name: path,
          child: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        ),
        routes: routes,
      );

  late final router = GoRouter(
    initialLocation: SignInPage.path,
    observers: [AnalyticsObserver(getIt<AnalyticsService>())],
    routes: <RouteBase>[
      GoRoute(
        path: SignInPage.path,
        builder: (context, state) => const SignInPage(),
        routes: [
          GoRoute(
            path: SignUpPage.path,
            builder: (context, state) => const SignUpPage(),
            routes: [
              GoRoute(
                path: VerificationPage.path,
                builder: (context, state) => VerificationPage(
                  navigation: state.queryParams['navigation'] ?? '',
                ),
              ),
            ],
          ),
        ],
      ),
      ShellRoute(
        observers: [AnalyticsObserver(getIt<AnalyticsService>())],
        pageBuilder: (context, state, Widget child) => NoTransitionPage<void>(
          name: 'Main',
          key: state.pageKey,
          child: BlocProvider<LocalAuthCubit>(
            create: (_) {
              final localAuthentication = getIt<LocalAuthentication>();

              final localAuthLocalDataSource =
                  DefaultLocalAuthLocalDataSource(localAuthentication);

              final localAuthService = DefaultLocalAuthService(
                localDataSource: localAuthLocalDataSource,
              );

              final sharedPreferences = getIt<SharedPreferences>();
              final localAppSettingsDataSource =
                  DefaultAppSettingsLocalDataSource(sharedPreferences);

              final appSettingsService = DefaultAppSettingsService(
                localDataSource: localAppSettingsDataSource,
              );

              return LocalAuthCubit(
                localizedReason: 'Authenticate',
                localAuthService: localAuthService,
                appSettingsService: appSettingsService,
              );
            },
            child: MainScreen(child: child),
          ),
        ),
        routes: <RouteBase>[
          _goRoute(
            path: HomePage.path,
            page: const HomePage(),
            routes: [
              _goRoute(
                path: NotificationsListScreen.path,
                page: const NotificationsListScreen(),
              ),
              _goRoute(
                path: LocationPage.path,
                page: const LocationPage(),
              ),
              _goRoute(
                path: JourneyPage.path,
                page: const JourneyPage(),
              ),
              _goRoute(
                path: DigitalIdPage.path,
                page: const DigitalIdPage(),
              ),
              _goRoute(
                path: VisitRequestsPage.path,
                page: const VisitRequestsPage(),
              ),
              _goRoute(
                path: VideoPlayerPage.path,
                page: const VideoPlayerPage(),
              ),
              _goRoute(
                path: AudioPlayerPage.path,
                page: const AudioPlayerPage(),
              ),
            ],
          ),
          _goRoute(
            path: ProfilePage.path,
            page: const ProfilePage(),
            routes: [
              _goRoute(
                path: SecuritySettingsPage.path,
                page: const SecuritySettingsPage(),
              ),
              _goRoute(
                path: NotificationsSettingsPage.path,
                page: const NotificationsSettingsPage(),
              ),
              _goRoute(
                path: AboutSettingsPage.path,
                page: const AboutSettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  final authorizationService = getIt<AuthorizationService>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      authorizationService.token;
    });

    // No need to close as initState will be called only once
    authorizationService.isAuthorized.distinct().listen((isAuthorized) {
      if (isAuthorized) {
        router.go(HomePage.path);
      } else {
        router.go(SignInPage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PSSN',
      routerConfig: router,
      theme: getLightThemeData(),
      darkTheme: getDarkThemeData(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (_, child) => child ?? const SizedBox.shrink(),
    );
  }
}
