import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_bo.freezed.dart';

@freezed
class LocationBO with _$LocationBO {
  const factory LocationBO({
    @Default(0) double latitude,
    @Default(0) double longitude,
    double? heading,
  }) = _LocationBO;
}
