import 'package:pssn/common/business_objects/result.dart';

abstract class NotificationService {
  Future<Result<bool>> initialize();
  Future<void> dispose();
}
