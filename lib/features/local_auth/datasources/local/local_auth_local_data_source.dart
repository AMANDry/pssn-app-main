import 'package:pssn/common/business_objects/result.dart';

abstract class LocalAuthLocalDataSource {
  Future<Result<bool>> authenticate(String localizedReason);
}
