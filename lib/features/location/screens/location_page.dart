import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/location/cubit/location_cubit.dart';
import 'package:pssn/features/location/cubit/location_state.dart';
import 'package:pssn/features/location/datasources/local/default_location_local_data_source.dart';
import 'package:pssn/features/location/repositories/location_service.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  static const path = 'location';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationCubit>(
      create: (_) {
        final locationLocalDataSource = DefaultLocationLocalDataSource(getIt());

        final locationRepository = DefaultLocationService(
          localDataSource: locationLocalDataSource,
        );
        return LocationCubit(locationRepository)..initialize();
      },
      child: Scaffold(
        body: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, LocationState state) {
            return Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        context.read<LocationCubit>().getLocation(),
                    child: const Text('Get Location'),
                  ),
                  state.when(
                    loading: () => const CircularProgressIndicator(),
                    data: (bo) => Text("${bo.latitude}:${bo.longitude}"),
                    error: (exception) => Text(exception.message),
                  ),
                  const Text('Listen location:'),
                  StreamBuilder(
                    stream: context.read<LocationCubit>().onLocation,
                    builder: (context, snapshot) =>
                        snapshot.data?.when(
                          success: (data) =>
                              Text("${data.latitude}:${data.longitude}"),
                          failed: (e) => Text(e.toString()),
                        ) ??
                        Text(
                          snapshot.error?.toString() ?? "Unknown",
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
