import 'package:dio/dio.dart';
import 'package:pssn/features/digital_id/dtos/digital_id_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'digital_id_api.g.dart';

@RestApi()
abstract class DigitalIdApi {
  factory DigitalIdApi(Dio client) = _DigitalIdApi;

  @GET('/digitalid')
  Future<DigitalIdDTO> getDigitalId();

  @POST('/digitalid')
  Future<DigitalIdDTO> postDigitalId(@Body() DigitalIdDTO digitalIdDTO);
}
