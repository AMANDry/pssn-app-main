import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/extensions.dart';
import 'package:pssn/features/journey/business_objects/journey_bo.dart';
import 'package:pssn/features/journey/datasources/api/journey_api.dart';
import 'package:pssn/features/journey/datasources/remote/journey_remote_data_source.dart';

class DefaultJourneyRemoteDataSource implements JourneyRemoteDataSource {
  DefaultJourneyRemoteDataSource(JourneyApi? api) : _api = api ?? getIt();

  final JourneyApi _api;

  @override
  Future<Result<JourneyBO>> getJourney() async {
    return _api.getJourney().toResult<JourneyBO>(mapper: (dto) => dto.toBo());
  }

  @override
  Future<Result<JourneyBO>> newJourney() {
    return _api.newJourney().toResult<JourneyBO>(mapper: (dto) => dto.toBo());
  }
}
