import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/sign_up/business_objects/sign_up_bo.dart';
import 'package:pssn/features/sign_up/datasources/remote/sign_up_remote_data_source.dart';

abstract class SignUpRepository {
  Future<Result<SignUpBO>> signUp(SignUpBO signUpBO);
}

class DefaultSignUpRepository implements SignUpRepository {
  DefaultSignUpRepository({
    required SignUpRemoteDataSource? remoteDataSource,
  }) : _signUpRemoteDataSource = remoteDataSource ?? getIt();

  final SignUpRemoteDataSource _signUpRemoteDataSource;

  @override
  Future<Result<SignUpBO>> signUp(SignUpBO signUpBO) {
    return _signUpRemoteDataSource.signUp(signUpBO);
  }
}
