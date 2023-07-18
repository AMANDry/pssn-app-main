import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/profile/business_objects/profile_bo.dart';

abstract class ProfileRemoteDataSource {
  Future<Result<ProfileBO>> getProfile();
  Future<Result<String>> updateProfilePicture();
}
