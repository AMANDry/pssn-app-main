import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/extensions.dart';
import 'package:pssn/features/digital_id/business_objects/digital_id_bo.dart';
import 'package:pssn/features/digital_id/datasources/api/digital_id_api.dart';
import 'package:pssn/features/digital_id/datasources/remote/digital_id_remote_data_source.dart';
import 'package:pssn/features/digital_id/dtos/digital_id_dto.dart';

class DefaultDigitalIdRemoteDataSource implements DigitalIdRemoteDataSource {
  DefaultDigitalIdRemoteDataSource(DigitalIdApi? api) : _api = api ?? getIt();

  final DigitalIdApi _api;

  @override
  Future<Result<DigitalIdBO>> getDigitalId() async {
    return _api
        .getDigitalId()
        .toResult<DigitalIdBO>(mapper: (dto) => dto.toBo());
  }

  @override
  Future<Result<DigitalIdBO>> createDigitalID(DigitalIdBO digitalIdBO) async {
    final digitalIdDTO =
        DigitalIdDTO(id: digitalIdBO.id, name: digitalIdBO.name);

    return _api
        .postDigitalId(digitalIdDTO)
        .toResult<DigitalIdBO>(mapper: (dto) => dto.toBo());
  }
}
