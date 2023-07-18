import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/extensions.dart';
import 'package:pssn/features/visit_requests/business_objects/visit_requests_bo.dart';
import 'package:pssn/features/visit_requests/datasources/api/visit_requests_api.dart';
import 'package:pssn/features/visit_requests/datasources/remote/visit_requests_remote_data_source.dart';

class DefaultVisitRequestsRemoteDataSource implements VisitRequestsRemoteDataSource {
  DefaultVisitRequestsRemoteDataSource(VisitRequestsApi? api) : _api = api ?? getIt();

  final VisitRequestsApi _api;

  @override
  Future<Result<VisitRequestsBO>> getVisitRequests() async {
    return _api.getVisitRequests().toResult<VisitRequestsBO>(mapper: (dto) => dto.toBo());
  }

  @override
  Future<Result<VisitRequestsBO>> createVisitRequests() async {
    return _api.createVisitRequests().toResult<VisitRequestsBO>(mapper: (dto) => dto.toBo());
  }
}
