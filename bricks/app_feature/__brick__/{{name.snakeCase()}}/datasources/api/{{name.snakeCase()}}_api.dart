import 'package:dio/dio.dart';
import 'package:pssn/features/{{name.snakeCase()}}/dtos/{{name.snakeCase()}}_dto.dart';
import 'package:retrofit/retrofit.dart';

part '{{name.snakeCase()}}_api.g.dart';

@RestApi()
abstract class {{name.pascalCase()}}Api {
  factory {{name.pascalCase()}}Api(Dio client) = _{{name.pascalCase()}}Api;

  @GET('/path')
  Future<{{name.pascalCase()}}DTO> get{{name.pascalCase()}}();
}
