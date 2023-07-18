import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/extensions.dart';
import 'package:pssn/features/{{name.snakeCase()}}/business_objects/{{name.snakeCase()}}_bo.dart';
import 'package:pssn/features/{{name.snakeCase()}}/datasources/api/{{name.snakeCase()}}_api.dart';
import 'package:pssn/features/{{name.snakeCase()}}/datasources/remote/{{name.snakeCase()}}_remote_data_source.dart';

class Default{{name.pascalCase()}}RemoteDataSource implements {{name.pascalCase()}}RemoteDataSource {
  Default{{name.pascalCase()}}RemoteDataSource({{name.pascalCase()}}Api? api) : _api = api ?? getIt();

  final {{name.pascalCase()}}Api _api;

  @override
  Future<Result<{{name.pascalCase()}}BO>> get{{name.pascalCase()}}() async {
    return _api.get{{name.pascalCase()}}().toResult<{{name.pascalCase()}}BO>(mapper: (dto) => dto.toBo());
  }
}
