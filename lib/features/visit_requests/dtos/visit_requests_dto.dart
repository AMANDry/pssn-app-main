import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/visit_requests/business_objects/visit_requests_bo.dart';

part 'visit_requests_dto.freezed.dart';
part 'visit_requests_dto.g.dart';

@freezed
class VisitRequestsDTO with _$VisitRequestsDTO {
  const factory VisitRequestsDTO({@Default(0) int id}) = _VisitRequestsDTO;

  const VisitRequestsDTO._();

  VisitRequestsBO toBo() => VisitRequestsBO(id);

  factory VisitRequestsDTO.fromJson(Map<String, dynamic> json) =>
      _$VisitRequestsDTOFromJson(json);
}
