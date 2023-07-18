import 'package:dio/dio.dart';
import 'package:pssn/features/journey/dtos/journey_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'journey_api.g.dart';

@RestApi()
abstract class JourneyApi {
  factory JourneyApi(Dio client) = _JourneyApi;

  @GET('/journey')
  Future<JourneyDTO> getJourney();

  @POST('/journey')
  Future<JourneyDTO> newJourney();

}
