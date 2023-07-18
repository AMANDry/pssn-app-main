import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/{{name.snakeCase()}}/business_objects/{{name.snakeCase()}}_bo.dart';

part '{{name.snakeCase()}}_dto.freezed.dart';
part '{{name.snakeCase()}}_dto.g.dart';

@freezed
class {{name.pascalCase()}}DTO with _${{name.pascalCase()}}DTO {
  const factory {{name.pascalCase()}}DTO({@Default(0) int id}) = _{{name.pascalCase()}}DTO;

  const {{name.pascalCase()}}DTO._();

  {{name.pascalCase()}}BO toBo() => {{name.pascalCase()}}BO(id);

  factory {{name.pascalCase()}}DTO.fromJson(Map<String, dynamic> json) =>
      _${{name.pascalCase()}}DTOFromJson(json);
}
