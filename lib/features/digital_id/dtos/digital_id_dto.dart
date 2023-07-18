import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/digital_id/business_objects/digital_id_bo.dart';

part 'digital_id_dto.freezed.dart';

part 'digital_id_dto.g.dart';

@freezed
class DigitalIdDTO with _$DigitalIdDTO {
  const factory DigitalIdDTO({
    @Default(0) int id,
    @Default('Default') String name,
  }) = _DigitalIdDTO;

  const DigitalIdDTO._();

  DigitalIdBO toBo() => DigitalIdBO(id: id, name: name);

  factory DigitalIdDTO.fromJson(Map<String, dynamic> json) =>
      _$DigitalIdDTOFromJson(json);
}
