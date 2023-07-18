import 'dart:async';

import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/location/business_objects/location_bo.dart';
import 'package:pssn/features/location/datasources/local/location_local_data_source.dart';
import 'package:pssn/features/location/dtos/location_dto.dart';
import 'package:pssn/features/location/exceptions/app_location_exception.dart';

class DefaultLocationLocalDataSource implements LocationLocalDataSource {
  DefaultLocationLocalDataSource(Location? location)
      : _location = location ?? getIt();

  final Location _location;

  @override
  Future<Result<bool>> initialize() async {
    try {
      return Result.success(await _location.enableBackgroundMode());
    } on Exception catch (exception) {
      return Result.failed(AppUnknownException(exception.toString()));
    }
  }

  @override
  Future<Result<LocationBO>> getLocation() async {
    try {
      final locationData = await _location.getLocation();
      final location = locationData.toDto()?.toBo();
      return location == null
          ? Result<LocationBO>.failed(AppUnknownException('Location is null'))
          : Result.success(location);
    } on Exception catch (exception) {
      return Result.failed(_handleException(exception));
    }
  }

  @override
  Stream<Result<LocationBO>> get onLocation {
    return _location.onLocationChanged.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          final location = data.toDto()?.toBo();
          if (location == null) return;
          sink.add(Result.success(location));
        },
        handleError: (error, stackTrace, sink) {
          sink.add(Result.failed(_handleException(error as Exception)));
        },
      ),
    );
  }

  AppException _handleException(Exception exception) {
    if (exception is PlatformException) {
      if (exception.code == "PERMISSION_DENIED") {
        return AppLocationException(
          exception.message ?? 'Permission denied',
          AppLocationException.permissionDenied,
        );
      }
    }
    return AppUnknownException(exception.toString());
  }
}

extension LocationExt on LocationData {
  LocationDTO? toDto() {
    final latitude = this.latitude;
    final longitude = this.longitude;
    if (latitude == null || longitude == null) return null;
    return LocationDTO(
      latitude: latitude,
      longitude: longitude,
      heading: heading,
    );
  }
}
