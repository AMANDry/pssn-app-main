import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/location/business_objects/location_bo.dart';

part 'location_dto.freezed.dart';

part 'location_dto.g.dart';

@freezed
class LocationDTO with _$LocationDTO {
  const factory LocationDTO({
    @Default(0) double latitude,
    @Default(0) double longitude,
    double? heading,
  }) = _LocationDTO;

  const LocationDTO._();

  LocationBO toBo() => LocationBO(
        latitude: latitude,
        longitude: longitude,
        heading: heading,
      );

  factory LocationDTO.fromJson(Map<String, dynamic> json) =>
      _$LocationDTOFromJson(json);
}
