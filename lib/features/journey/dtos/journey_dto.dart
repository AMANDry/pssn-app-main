import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/journey/business_objects/journey_bo.dart';

part 'journey_dto.freezed.dart';
part 'journey_dto.g.dart';

@freezed
class JourneyDTO with _$JourneyDTO {
  const factory JourneyDTO({@Default(0) int id}) = _JourneyDTO;

  const JourneyDTO._();

  JourneyBO toBo() => JourneyBO(id);

  factory JourneyDTO.fromJson(Map<String, dynamic> json) =>
      _$JourneyDTOFromJson(json);
}
