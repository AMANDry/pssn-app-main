import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/profile/cubit/profile_state.dart';
import 'package:pssn/features/profile/repositories/profile_service.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(ProfileService? profileRepository)
      : _profileService = profileRepository ?? getIt.get(),
        super(const ProfileState.loading());

  final ProfileService _profileService;

  Future<void> getProfile() async {
    emit(const ProfileState.loading());

    final result = await _profileService.getProfile();

    emit(
      result.when(
        success: ProfileState.data,
        failed: ProfileState.error,
      ),
    );
  }

  Future<void> updateProfilePicture() async {
    final localPictureResult = await _profileService.pickupProfilePicture();
    final remotePictureResult = await _profileService.updateProfilePicture();
    final profileResult = await _profileService.getProfile();

    combine3Results(
      localPictureResult,
      remotePictureResult,
      profileResult,
      onSuccess: (localPictureResult, remotePictureResult, profileResult) {
        emit(ProfileState.data(profileResult));
      },
      onFailure: (exception) {
        emit(ProfileState.error(exception));
      },
    );
  }
}
