import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_bo.freezed.dart';

@freezed
class {{name.pascalCase()}}BO with _${{name.pascalCase()}}BO {
  const factory {{name.pascalCase()}}BO(int id) = _{{name.pascalCase()}}BO;
}
