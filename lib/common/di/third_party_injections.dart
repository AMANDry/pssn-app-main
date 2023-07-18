import 'package:file_picker/file_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';

class ThirdPartyInjections {
  Logger get logger => Logger(
        printer: PrettyPrinter(colors: false, methodCount: 0, lineLength: 100),
      );

  FilePicker get filePicker => FilePicker.platform;

  LocalAuthentication get localAuthentication => LocalAuthentication();

  Location get location => Location();

  FirebaseAnalytics get firebaseAnalytics => FirebaseAnalytics.instance;

  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  final AndroidOptions _androidOptions =
      const AndroidOptions(encryptedSharedPreferences: true);

  FlutterSecureStorage get secureStorage =>
      FlutterSecureStorage(aOptions: _androidOptions);

  Future<SharedPreferences> get sharedPreferences async =>
      SharedPreferences.getInstance();

  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      FlutterLocalNotificationsPlugin();

  GoogleSignIn get googleSignIn => GoogleSignIn();

  FacebookAuth get facebookAuth => FacebookAuth.instance;

  TwitterLogin get twitterLogin => TwitterLogin(
        apiKey: 'apiKey',
        apiSecretKey: 'apiSecretKey',
        redirectURI: 'redirectURI',
      );
}
