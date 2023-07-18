import 'package:dio/dio.dart';
import 'package:pssn/features/verification/dtos/verification_dto.dart';
import 'package:pssn/features/verification/dtos/verification_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'verification_api.g.dart';

@RestApi()
abstract class VerificationApi {
  factory VerificationApi(Dio client) = _VerificationApi;

  @POST('/verification')
  Future<VerificationResponseDTO> verification(@Body() VerificationDTO verificationDTO);
}
