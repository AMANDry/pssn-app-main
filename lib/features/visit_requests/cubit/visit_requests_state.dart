import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/visit_requests/business_objects/visit_requests_bo.dart';

part 'visit_requests_state.freezed.dart';

@freezed
class VisitRequestsState with _$VisitRequestsState {
  const factory VisitRequestsState.loading() = _Loading;
  const factory VisitRequestsState.data(VisitRequestsBO data) = _Data;
  const factory VisitRequestsState.error(AppException error) = _Error;
}
