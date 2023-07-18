import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/{{name.snakeCase()}}/business_objects/{{name.snakeCase()}}_bo.dart';
import 'package:pssn/features/{{name.snakeCase()}}/datasources/local/{{name.snakeCase()}}_local_data_source.dart';
import 'package:pssn/features/{{name.snakeCase()}}/datasources/remote/{{name.snakeCase()}}_remote_data_source.dart';

abstract class {{name.pascalCase()}}Repository {
  Future<Result<{{name.pascalCase()}}BO>> get{{name.pascalCase()}}();
}

class Default{{name.pascalCase()}}Repository implements {{name.pascalCase()}}Repository {
  Default{{name.pascalCase()}}Repository({
    required {{name.pascalCase()}}LocalDataSource? localDataSource,
    required {{name.pascalCase()}}RemoteDataSource? remoteDataSource,
  })  : _{{name.camelCase()}}RemoteDataSource = remoteDataSource ?? getIt(),
        _{{name.camelCase()}}LocalDataSource = localDataSource ?? getIt();

  final {{name.pascalCase()}}LocalDataSource _{{name.camelCase()}}LocalDataSource;
  final {{name.pascalCase()}}RemoteDataSource _{{name.camelCase()}}RemoteDataSource;

  @override
  Future<Result<{{name.pascalCase()}}BO>> get{{name.pascalCase()}}() {
    return DateTime.now().second.isEven
        ? _{{name.camelCase()}}RemoteDataSource.get{{name.pascalCase()}}()
        : _{{name.camelCase()}}LocalDataSource.get{{name.pascalCase()}}();
  }
}
