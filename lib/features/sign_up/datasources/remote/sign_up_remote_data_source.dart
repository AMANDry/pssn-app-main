import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/sign_up/business_objects/sign_up_bo.dart';

abstract class SignUpRemoteDataSource {
  Future<Result<SignUpBO>> signUp(SignUpBO signUpBO);
}
