import 'package:dio/dio.dart';
import 'package:pssn/features/profile/dtos/profile_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio client) = _ProfileApi;

  @GET('/profile')
  Future<ProfileDTO> getProfile();

  @GET('/profile/picture')
  Future<String> updateProfilePicture();
}
