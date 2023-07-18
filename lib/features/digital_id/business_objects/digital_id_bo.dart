import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_id_bo.freezed.dart';

@freezed
class DigitalIdBO with _$DigitalIdBO {
  const factory DigitalIdBO({required int id, required String name}) =
      _DigitalIdBO;
}
