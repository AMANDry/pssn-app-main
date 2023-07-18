import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/location/business_objects/location_bo.dart';

abstract class LocationLocalDataSource {
  Future<Result<bool>> initialize();
  Future<Result<LocationBO>> getLocation();
  Stream<Result<LocationBO>> get onLocation;
}
