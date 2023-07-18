import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/verification/business_objects/verification_bo.dart';
import 'package:pssn/features/verification/business_objects/verification_response_bo.dart';

abstract class VerificationRemoteDataSource {
  Future<Result<VerificationResponseBO>> verification(VerificationBO verificationBO);
}
