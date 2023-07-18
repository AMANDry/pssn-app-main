import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/analytics/datasources/remote/analytics_remote_data_source.dart';

class DefaultAnalyticsRemoteDataSource implements AnalyticsRemoteDataSource {
  DefaultAnalyticsRemoteDataSource(FirebaseAnalytics? firebaseAnalytics)
      : _firebaseAnalytics = firebaseAnalytics ?? getIt();

  final FirebaseAnalytics _firebaseAnalytics;

  @override
  Future<Result<bool>> initialize() async {
    return const Result.success(true);
  }

  @override
  Future<Result<bool>> logCustomEvent(String name) async {
    await _firebaseAnalytics.logEvent(name: name);

    return const Result.success(true);
  }

  @override
  Future<Result<bool>> logScreenView(String name) async {
    await _firebaseAnalytics.setCurrentScreen(screenName: name);

    return const Result.success(true);
  }
}
