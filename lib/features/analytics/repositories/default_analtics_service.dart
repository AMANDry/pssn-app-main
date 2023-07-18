import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/analytics/datasources/remote/analytics_remote_data_source.dart';
import 'package:pssn/features/analytics/repositories/analytics_service.dart';

class DefaultAnalyticsService implements AnalyticsService {
  DefaultAnalyticsService(
    AnalyticsRemoteDataSource? analyticsRemoteDataSource,
  ) : _analyticsRemoteDataSource = analyticsRemoteDataSource ?? getIt();

  final AnalyticsRemoteDataSource _analyticsRemoteDataSource;

  @override
  Future<Result<bool>> initialize() {
    return _analyticsRemoteDataSource.initialize();
  }

  @override
  Future<Result<bool>> logCustomEvent(String name) {
    return _analyticsRemoteDataSource.logCustomEvent(name);
  }

  @override
  Future<Result<bool>> logScreenView(String name) {
    return _analyticsRemoteDataSource.logScreenView(name);
  }

  @override
  Future<void> dispose() async {}
}
