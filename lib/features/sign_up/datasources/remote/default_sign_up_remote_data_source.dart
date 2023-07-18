import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/extensions.dart';
import 'package:pssn/features/sign_up/business_objects/sign_up_bo.dart';
import 'package:pssn/features/sign_up/datasources/api/sign_up_api.dart';
import 'package:pssn/features/sign_up/datasources/remote/sign_up_remote_data_source.dart';
import 'package:pssn/features/sign_up/dtos/sign_up_dto.dart';

class DefaultSignUpRemoteDataSource implements SignUpRemoteDataSource {
  DefaultSignUpRemoteDataSource(SignUpApi? api) : _api = api ?? getIt();

  final SignUpApi _api;

  @override
  Future<Result<SignUpBO>> signUp(SignUpBO signUpBO) async {
    final signUpDTO = SignUpDTO(
      email: signUpBO.email,
      password: signUpBO.password,
    );

    return _api
        .signUp(signUpDTO)
        .toResult<SignUpBO>(mapper: (dto) => dto.toBo());
  }
}
