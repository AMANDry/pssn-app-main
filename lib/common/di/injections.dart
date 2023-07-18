import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:pssn/common/blocs/app_bloc_observer.dart';
import 'package:pssn/common/di/third_party_injections.dart';
import 'package:pssn/common/helpers/app_variables.dart';
import 'package:pssn/common/navigation/analytics_observer.dart';
import 'package:pssn/common/network/interceptors/logging_interceptor.dart';
import 'package:pssn/common/network/interceptors/mock_interceptor.dart';
import 'package:pssn/common/network/interceptors/refresh_interceptor.dart';
import 'package:pssn/common/network/network_manager.dart';
import 'package:pssn/features/analytics/datasources/remote/analytics_remote_data_source.dart';
import 'package:pssn/features/analytics/datasources/remote/default_analytics_remote_data_source.dart';
import 'package:pssn/features/analytics/repositories/analytics_service.dart';
import 'package:pssn/features/analytics/repositories/default_analtics_service.dart';
import 'package:pssn/features/authorization/datasources/api/authorization_api.dart';
import 'package:pssn/features/authorization/datasources/api/token_refresh_api.dart';
import 'package:pssn/features/authorization/datasources/local/authorization_local_data_source.dart';
import 'package:pssn/features/authorization/datasources/local/default_authorization_local_data_source.dart';
import 'package:pssn/features/authorization/datasources/remote/authorization_remote_data_source.dart';
import 'package:pssn/features/authorization/datasources/remote/default_authorization_remote_data_source.dart';
import 'package:pssn/features/authorization/repositories/authorization_service.dart';
import 'package:pssn/features/notification/datasources/api/notifications_history_api.dart';
import 'package:pssn/features/notification/datasources/local/android_local_notification_data_source.dart';
import 'package:pssn/features/notification/datasources/local/ios_local_notification_data_source.dart';
import 'package:pssn/features/notification/datasources/local/local_notification_data_source.dart';
import 'package:pssn/features/notification/datasources/local/web_local_notifcation_data_source.dart';
import 'package:pssn/features/notification/datasources/remote/default_remote_notifications_data_source.dart';
import 'package:pssn/features/notification/datasources/remote/remote_notification_data_source.dart';
import 'package:pssn/features/notification/service/default_notification_service.dart';
import 'package:pssn/features/notification/service/notification_service.dart';
import 'package:pssn/features/video_player/screens/video_player_controller_registry.dart';
import 'package:pssn/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureInjection() async {
  final thirdPartyInjections = ThirdPartyInjections();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  getIt
    // Third party
    ..registerSingleton<Logger>(thirdPartyInjections.logger)
    ..registerSingleton<FilePicker>(thirdPartyInjections.filePicker)
    ..registerSingleton<LocalAuthentication>(
      thirdPartyInjections.localAuthentication,
    )
    ..registerSingleton<Location>(
      thirdPartyInjections.location,
    )
    ..registerSingleton<GoogleSignIn>(
      thirdPartyInjections.googleSignIn,
    )
    ..registerSingleton<FacebookAuth>(
      thirdPartyInjections.facebookAuth,
    )
    ..registerSingleton<TwitterLogin>(
      thirdPartyInjections.twitterLogin,
    )
    ..registerSingleton<FirebaseMessaging>(
      thirdPartyInjections.firebaseMessaging,
    )
    ..registerSingleton<FirebaseAnalytics>(
      thirdPartyInjections.firebaseAnalytics
        ..setAnalyticsCollectionEnabled(false),
    )
    ..registerSingleton<FlutterLocalNotificationsPlugin>(
      thirdPartyInjections.flutterLocalNotificationsPlugin,
    )
    ..registerSingletonAsync<SharedPreferences>(
      () => thirdPartyInjections.sharedPreferences,
    )
    ..registerSingletonAsync<FlutterSecureStorage>(
      () async {
        final sharedPreferences = getIt<SharedPreferences>();
        final secureStorage = thirdPartyInjections.secureStorage;
        if (!(kIsWeb || Platform.isAndroid)) {
          // FlutterSecureStorage workaround for persistent iOS token
          if (sharedPreferences.getBool(AppRuntimeVars.freshInstallKey) ??
              true) {
            await secureStorage.deleteAll();
            sharedPreferences.setBool(AppRuntimeVars.freshInstallKey, false);
          }
        }
        return secureStorage;
      },
      dependsOn: [SharedPreferences],
    );

  await getIt.allReady();

  // Network
  final baseUri = Uri.tryParse(AppCompileTimeVars.baseUrl);
  // Token refesh client is needed for [RefreshInterceptor] which is [QueuedInterceptor]
  // and allows only one request
  final tokenRefreshClient = NetworkManager.getApiDioClient(
    baseUrl: baseUri,
    interceptors: [
      if (kDebugMode) MockInterceptor(),
      LoggingInterceptor(),
    ],
  );
  final dioClient = NetworkManager.getApiDioClient(
    baseUrl: baseUri,
    interceptors: [
      RefreshInterceptor(tokenRefreshClient),
      if (kDebugMode) MockInterceptor(),
    ],
  );

  getIt

    // Common
    ..registerSingleton<Dio>(dioClient)
    ..registerSingleton<BlocObserver>(AppBlocObserver())
    ..registerFactory<AnalyticsObserver>(
      () => AnalyticsObserver(getIt<AnalyticsService>()),
    )
    // Analytics
    ..registerSingleton<AnalyticsRemoteDataSource>(
      DefaultAnalyticsRemoteDataSource(getIt<FirebaseAnalytics>()),
    )
    ..registerSingleton<AnalyticsService>(
      DefaultAnalyticsService(getIt<AnalyticsRemoteDataSource>())..initialize(),
    )
    // Authorization
    ..registerSingleton<AuthorizationApi>(AuthorizationApi(getIt<Dio>()))
    ..registerSingleton<TokenRefreshApi>(TokenRefreshApi(tokenRefreshClient))
    ..registerSingleton<AuthorizationLocalDataSource>(
      DefaultAuthorizationLocalDataSource(getIt<FlutterSecureStorage>()),
    )
    ..registerSingleton<AuthorizationRemoteDataSource>(
      DefaultAuthorizationRemoteDataSource(
        getIt<AuthorizationApi>(),
        getIt<TokenRefreshApi>(),
      ),
    )
    ..registerSingleton<AuthorizationService>(
      DefaultAuthorizationService(
        authorizationLocalDataSource: getIt<AuthorizationLocalDataSource>(),
        authorizationRemoteDataSource: getIt<AuthorizationRemoteDataSource>(),
      ),
    )

    //Video player controller registry
    ..registerSingleton<VideoPlayerControllerRegistry>(
      VideoPlayerControllerRegistry(),
    )

    // Notifications
    ..registerSingleton<NotificationsHistoryApi>(
      NotificationsHistoryApi(getIt<Dio>()),
    )
    ..registerSingleton<RemoteNotificationsDataSource>(
      DefaultRemoteNotificationsDataSource(getIt<NotificationsHistoryApi>()),
    )
    ..registerLazySingleton<LocalNotificationDataSource>(
      () {
        if (kIsWeb) {
          return WebLocalNotificationDataSource(
            firebaseMessaging: getIt<FirebaseMessaging>(),
            localNotificationsPlugin: getIt<FlutterLocalNotificationsPlugin>(),
          );
        } else if (Platform.isAndroid) {
          return AndroidLocalNotificationDataSource(
            firebaseMessaging: getIt<FirebaseMessaging>(),
            localNotificationsPlugin: getIt<FlutterLocalNotificationsPlugin>(),
          );
        }
        return IOSLocalNotificationDataSource(
          firebaseMessaging: getIt<FirebaseMessaging>(),
          localNotificationsPlugin: getIt<FlutterLocalNotificationsPlugin>(),
        );
      },
    )
    ..registerSingleton<NotificationService>(
      DefaultNotificationService(
        localNoficationDataSource: getIt<LocalNotificationDataSource>(),
        remoteNotificationDataSource: getIt<RemoteNotificationsDataSource>(),
      )..initialize(),
    );

  await getIt.allReady();
}
