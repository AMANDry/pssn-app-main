import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/app_settings/screens/app_settings_view.dart';
import 'package:pssn/features/authorization/repositories/authorization_service.dart';
import 'package:pssn/features/profile/business_objects/profile_bo.dart';
import 'package:pssn/features/profile/cubit/profile_cubit.dart';
import 'package:pssn/features/profile/cubit/profile_state.dart';
import 'package:pssn/features/profile/datasources/api/profile_api.dart';
import 'package:pssn/features/profile/datasources/local/default_profile_local_data_source.dart';
import 'package:pssn/features/profile/datasources/remote/default_profile_remote_data_source.dart';
import 'package:pssn/features/profile/repositories/profile_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  static const path = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) {
        final filePicker = getIt<FilePicker>();
        final profileApi = ProfileApi(getIt());

        final profileRemoteDataSource =
            DefaultProfileRemoteDataSource(profileApi);
        final profileLocalDataSource =
            DefaultProfileLocalDataSource(filePicker);

        final profileRepository = DefaultProfileService(
          profileLocalDataSource: profileLocalDataSource,
          profileRemoteDataSource: profileRemoteDataSource,
        );
        return ProfileCubit(profileRepository)..getProfile();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          title: const Text('Profile'),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (_, ProfileState state) {
            return SizedBox.expand(
              child: Center(
                child: state.when(
                  loading: () => const CircularProgressIndicator(),
                  data: (profile) => _ProfileWidget(profile),
                  error: (exception) => Text(exception.message),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileWidget extends StatelessWidget {
  const _ProfileWidget(this.profile);

  final ProfileBO profile;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 50.h),
                      _UserPicture(profile),
                      SizedBox(height: 10.h),
                      Text(profile.fullName),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(height: 300, child: AppSettingsView()),
                ElevatedButton(
                  child: const Text('Sign out'),
                  onPressed: () {
                    getIt<AuthorizationService>().removeLocalToken();
                  },
                ),
                SizedBox(height: 20.h)
              ],
            ),
          ),
        ],
      ),
      notificationPredicate: (_) {
        return true;
      },
      onRefresh: () async {
        return context.read<ProfileCubit>().getProfile();
      },
    );
  }
}

class _UserPicture extends StatefulWidget {
  const _UserPicture(this.profile);

  final ProfileBO profile;

  @override
  State<StatefulWidget> createState() => _UserPictureState();
}

class _UserPictureState extends State<_UserPicture> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 53.w,
          backgroundColor: Colors.black,
          child: loading
              ? const CircularProgressIndicator(color: Colors.white)
              : CircleAvatar(
                  radius: 50.w,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  foregroundImage: NetworkImage(widget.profile.imageUrl),
                ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () async {
                setState(() {
                  loading = true;
                });

                await context.read<ProfileCubit>().updateProfilePicture();

                setState(() {
                  loading = false;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
