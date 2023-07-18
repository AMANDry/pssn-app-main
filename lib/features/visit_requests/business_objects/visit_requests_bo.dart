import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit_requests_bo.freezed.dart';

@freezed
class VisitRequestsBO with _$VisitRequestsBO {
  const factory VisitRequestsBO(int id) = _VisitRequestsBO;
}
