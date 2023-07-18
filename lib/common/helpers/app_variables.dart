class AppCompileTimeVars {
  static const String baseUrl = String.fromEnvironment('APP_BASE_URL');
  static const String vapidKey = String.fromEnvironment('APP_VAPID_KEY');
  static const String environment = String.fromEnvironment('APP_ENVIRONMENT');
  static const String encryptionKey =
      String.fromEnvironment('APP_ENCRYPTION_KEY');
}

class AppRuntimeVars {
  static const String defaultChannelId = '0';
  static const String defaultChannelName = 'APP_DEFAULT_NOTIFICATIONS_CHANNEL';
  static const freshInstallKey = 'freshInstall';
}
