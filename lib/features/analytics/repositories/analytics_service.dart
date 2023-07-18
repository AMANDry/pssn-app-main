import 'package:pssn/common/business_objects/result.dart';

abstract class AnalyticsService {
  Future<Result<bool>> initialize();
  Future<Result<bool>> logCustomEvent(String name);
  Future<Result<bool>> logScreenView(String name);
  Future<void> dispose();
}
