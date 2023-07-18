import 'package:dio/dio.dart';
import 'package:pssn/features/sign_up/dtos/sign_up_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'sign_up_api.g.dart';

@RestApi()
abstract class SignUpApi {
  factory SignUpApi(Dio client) = _SignUpApi;

  @POST('/sign-up')
  Future<SignUpDTO> signUp(@Body() SignUpDTO signUpDTO);
}
