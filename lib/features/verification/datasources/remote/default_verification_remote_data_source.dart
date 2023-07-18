import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/extensions.dart';
import 'package:pssn/features/verification/business_objects/verification_bo.dart';
import 'package:pssn/features/verification/business_objects/verification_response_bo.dart';
import 'package:pssn/features/verification/datasources/api/verification_api.dart';
import 'package:pssn/features/verification/datasources/remote/verification_remote_data_source.dart';
import 'package:pssn/features/verification/dtos/verification_dto.dart';

class DefaultVerificationRemoteDataSource
    implements VerificationRemoteDataSource {
  DefaultVerificationRemoteDataSource(VerificationApi? api)
      : _api = api ?? getIt();

  final VerificationApi _api;

  @override
  Future<Result<VerificationResponseBO>> verification(
    VerificationBO verificationBO,
  ) async {
    final verificationDTO = VerificationDTO.fromBo(verificationBO);

    return _api
        .verification(verificationDTO)
        .toResult<VerificationResponseBO>(mapper: (dto) => dto.toBO());
  }
}
