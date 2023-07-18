import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/verification/business_objects/verification_bo.dart';
import 'package:pssn/features/verification/business_objects/verification_response_bo.dart';
import 'package:pssn/features/verification/datasources/remote/verification_remote_data_source.dart';

abstract class VerificationRepository {
  Future<Result<VerificationResponseBO>> verification(VerificationBO verificationBO);
}

class DefaultVerificationRepository implements VerificationRepository {
  DefaultVerificationRepository({
    required VerificationRemoteDataSource? remoteDataSource,
  }) : _verificationRemoteDataSource = remoteDataSource ?? getIt();

  final VerificationRemoteDataSource _verificationRemoteDataSource;

  @override
  Future<Result<VerificationResponseBO>> verification(VerificationBO verificationBO) {
    return _verificationRemoteDataSource.verification(verificationBO);
  }
}
