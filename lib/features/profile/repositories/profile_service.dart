import 'dart:io';

import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/profile/business_objects/profile_bo.dart';
import 'package:pssn/features/profile/datasources/local/profile_local_data_source.dart';
import 'package:pssn/features/profile/datasources/remote/profile_remote_data_source.dart';

abstract class ProfileService {
  Future<Result<ProfileBO>> getProfile();
  Future<Result<File>> pickupProfilePicture();
  Future<Result<String>> updateProfilePicture();
}

class DefaultProfileService implements ProfileService {
  DefaultProfileService({
    required ProfileRemoteDataSource? profileRemoteDataSource,
    required ProfileLocalDataSource? profileLocalDataSource,
  })  : _profileLocalDataSource = profileLocalDataSource ?? getIt(),
        _profileRemoteDataSource = profileRemoteDataSource ?? getIt();

  final ProfileRemoteDataSource _profileRemoteDataSource;
  final ProfileLocalDataSource _profileLocalDataSource;

  @override
  Future<Result<ProfileBO>> getProfile() {
    return _profileRemoteDataSource.getProfile();
  }

  @override
  Future<Result<String>> updateProfilePicture() async {
    return _profileRemoteDataSource.updateProfilePicture();
  }

  @override
  Future<Result<File>> pickupProfilePicture() async {
    return _profileLocalDataSource.pickupProfileImage();
  }
}
