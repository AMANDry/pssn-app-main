import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/journey/business_objects/journey_bo.dart';

abstract class JourneyRemoteDataSource {
  Future<Result<JourneyBO>> getJourney();

  Future<Result<JourneyBO>> newJourney();


}
