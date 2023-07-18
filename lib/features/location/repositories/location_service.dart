import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/location/business_objects/location_bo.dart';
import 'package:pssn/features/location/datasources/local/location_local_data_source.dart';

abstract class LocationService {
  Future<Result<bool>> initialize();

  Future<Result<LocationBO>> getLocation();

  Stream<Result<LocationBO>> get onLocation;
}

class DefaultLocationService implements LocationService {
  DefaultLocationService({
    required LocationLocalDataSource? localDataSource,
  }) : _locationLocalDataSource = localDataSource ?? getIt();

  final LocationLocalDataSource _locationLocalDataSource;

  @override
  Future<Result<bool>> initialize() => _locationLocalDataSource.initialize();

  @override
  Future<Result<LocationBO>> getLocation() =>
      _locationLocalDataSource.getLocation();

  @override
  Stream<Result<LocationBO>> get onLocation =>
      _locationLocalDataSource.onLocation;
}
