import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/digital_id/business_objects/digital_id_bo.dart';

abstract class DigitalIdRemoteDataSource {
  Future<Result<DigitalIdBO>> getDigitalId();

  Future<Result<DigitalIdBO>> createDigitalID(DigitalIdBO digitalIdBO);
}
