import 'package:dio/dio.dart';
import 'package:pssn/features/visit_requests/dtos/visit_requests_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'visit_requests_api.g.dart';

@RestApi()
abstract class VisitRequestsApi {
  factory VisitRequestsApi(Dio client) = _VisitRequestsApi;

  @GET('/visit-requests')
  Future<VisitRequestsDTO> getVisitRequests();

  @POST('/visit-requests')
  Future<VisitRequestsDTO> createVisitRequests();
}
