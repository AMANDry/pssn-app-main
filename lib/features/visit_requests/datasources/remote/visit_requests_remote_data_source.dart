import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/visit_requests/business_objects/visit_requests_bo.dart';

abstract class VisitRequestsRemoteDataSource {
  Future<Result<VisitRequestsBO>> getVisitRequests();
  Future<Result<VisitRequestsBO>> createVisitRequests();
}
