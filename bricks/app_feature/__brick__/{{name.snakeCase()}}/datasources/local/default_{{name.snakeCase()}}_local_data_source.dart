import 'dart:convert';

import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/{{name.snakeCase()}}/business_objects/{{name.snakeCase()}}_bo.dart';
import 'package:pssn/features/{{name.snakeCase()}}/datasources/local/{{name.snakeCase()}}_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Default{{name.pascalCase()}}LocalDataSource implements {{name.pascalCase()}}LocalDataSource {
  Default{{name.pascalCase()}}LocalDataSource(SharedPreferences? sharedPreferences) : _sharedPreferences = sharedPreferences ?? getIt();

  final SharedPreferences _sharedPreferences;

  @override
  Future<Result<{{name.pascalCase()}}BO>> get{{name.pascalCase()}}() async {
    try {
      final {{name.camelCase()}}JsonString =
          _sharedPreferences.getString('key'); //_box.get(0).map((entity) => entity.toBO());
      final {{name.camelCase()}}Json = jsonDecode({{name.camelCase()}}JsonString!) as Map<String, dynamic>;
      final {{name.camelCase()}}BO = {{name.pascalCase()}}BO({{name.camelCase()}}Json['id'] as int);

      return Result.success({{name.camelCase()}}BO);
    } on Exception catch (exception) {
      return Result.failed(AppUnknownException(exception.toString()));
    }
  }
}
