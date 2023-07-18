import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/visit_requests/business_objects/visit_requests_bo.dart';
import 'package:pssn/features/visit_requests/datasources/remote/visit_requests_remote_data_source.dart';

abstract class VisitRequestsRepository {
  Future<Result<VisitRequestsBO>> getVisitRequests();

  Future<Result<VisitRequestsBO>> createVisitRequests();
}

class DefaultVisitRequestsRepository implements VisitRequestsRepository {
  DefaultVisitRequestsRepository({
    required VisitRequestsRemoteDataSource? remoteDataSource,
  }) : _visitRequestsRemoteDataSource = remoteDataSource ?? getIt();

  final VisitRequestsRemoteDataSource _visitRequestsRemoteDataSource;

  @override
  Future<Result<VisitRequestsBO>> getVisitRequests() {
    return _visitRequestsRemoteDataSource.getVisitRequests();
  }

  @override
  Future<Result<VisitRequestsBO>> createVisitRequests() {
    return _visitRequestsRemoteDataSource.createVisitRequests();
  }
}
