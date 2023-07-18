import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/extensions.dart';
import 'package:pssn/features/profile/business_objects/profile_bo.dart';
import 'package:pssn/features/profile/datasources/api/profile_api.dart';
import 'package:pssn/features/profile/datasources/remote/profile_remote_data_source.dart';

class DefaultProfileRemoteDataSource implements ProfileRemoteDataSource {
  DefaultProfileRemoteDataSource(ProfileApi? profileApi)
      : _profileApi = profileApi ?? getIt();

  final ProfileApi _profileApi;

  @override
  Future<Result<ProfileBO>> getProfile() async {
    return _profileApi
        .getProfile()
        .toResult<ProfileBO>(mapper: (dto) => dto.toBo());
  }

  @override
  Future<Result<String>> updateProfilePicture() async {
    return _profileApi.updateProfilePicture().toResult();
  }
}
