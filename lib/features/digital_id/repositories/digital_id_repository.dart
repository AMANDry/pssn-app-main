import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/digital_id/business_objects/digital_id_bo.dart';
import 'package:pssn/features/digital_id/datasources/remote/digital_id_remote_data_source.dart';

abstract class DigitalIdRepository {
  Future<Result<DigitalIdBO>> getDigitalId();

  Future<Result<DigitalIdBO>> createDigitalId(DigitalIdBO digitalIdDBO);
}

class DefaultDigitalIdRepository implements DigitalIdRepository {
  DefaultDigitalIdRepository({
    required DigitalIdRemoteDataSource? remoteDataSource,
  }) : _digitalIdRemoteDataSource = remoteDataSource ?? getIt();

  final DigitalIdRemoteDataSource _digitalIdRemoteDataSource;

  @override
  Future<Result<DigitalIdBO>> getDigitalId() {
    return _digitalIdRemoteDataSource.getDigitalId();
  }

  @override
  Future<Result<DigitalIdBO>> createDigitalId(DigitalIdBO digitalIdBO) {
    return _digitalIdRemoteDataSource.createDigitalID(digitalIdBO);
  }
}
