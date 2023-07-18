import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/location/business_objects/location_bo.dart';
import 'package:pssn/features/location/cubit/location_state.dart';
import 'package:pssn/features/location/repositories/location_service.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(LocationService? locationService)
      : _locationService = locationService ?? getIt.get(),
        super(const LocationState.loading());

  final LocationService _locationService;

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    final result = await _locationService.initialize();
    result.when(
      success: (data) => _isInitialized = data,
      failed: (_) => _isInitialized = false,
    );
  }

  Future<void> getLocation() async {
    emit(const LocationState.loading());
    await initialize();
    final result = await _locationService.getLocation();

    emit(
      result.when(
        success: LocationState.data,
        failed: LocationState.error,
      ),
    );
  }

  Stream<Result<LocationBO>> get onLocation => _locationService.onLocation;
}
