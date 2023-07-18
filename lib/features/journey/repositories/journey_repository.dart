import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/journey/business_objects/journey_bo.dart';
import 'package:pssn/features/journey/datasources/remote/journey_remote_data_source.dart';

abstract class JourneyRepository {
  Future<Result<JourneyBO>> getJourney();

  Future<Result<JourneyBO>> newJourney();
}

class DefaultJourneyRepository implements JourneyRepository {
  DefaultJourneyRepository({
    required JourneyRemoteDataSource? remoteDataSource,
  }) : _journeyRemoteDataSource = remoteDataSource ?? getIt();

  final JourneyRemoteDataSource _journeyRemoteDataSource;

  @override
  Future<Result<JourneyBO>> getJourney() {
    return _journeyRemoteDataSource.getJourney();
  }

  @override
  Future<Result<JourneyBO>> newJourney() {
    return _journeyRemoteDataSource.newJourney();
  }
}
