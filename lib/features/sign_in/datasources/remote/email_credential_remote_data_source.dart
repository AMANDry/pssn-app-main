import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/sign_in/datasources/remote/credential_remote_data_source.dart';

class EmailCredentialRemoteDataSource extends CredentialRemoteDataSource {
  @override
  Future<Result<Map<String, String>>> getCredentials([
    Map<String, String>? data,
  ]) async {
    if (data == null) {
      return Result<Map<String, String>>.failed(
        AppUnknownException('Data is null'),
      );
    }
    return Result.success(data);
  }
}
