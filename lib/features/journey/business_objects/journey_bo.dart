import 'package:freezed_annotation/freezed_annotation.dart';

part 'journey_bo.freezed.dart';

@freezed
class JourneyBO with _$JourneyBO {
  const factory JourneyBO(int id) = _JourneyBO;
}
