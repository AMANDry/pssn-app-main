import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/{{name.snakeCase()}}/business_objects/{{name.snakeCase()}}_bo.dart';

abstract class {{name.pascalCase()}}RemoteDataSource {
  Future<Result<{{name.pascalCase()}}BO>> get{{name.pascalCase()}}();
}
