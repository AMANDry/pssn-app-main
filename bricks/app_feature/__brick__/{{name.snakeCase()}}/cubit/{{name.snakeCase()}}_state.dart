import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/{{name.snakeCase()}}/business_objects/{{name.snakeCase()}}_bo.dart';

part '{{name.snakeCase()}}_state.freezed.dart';

@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  const factory {{name.pascalCase()}}State.loading() = _Loading;
  const factory {{name.pascalCase()}}State.data({{name.pascalCase()}}BO data) = _Data;
  const factory {{name.pascalCase()}}State.error(AppException error) = _Error;
}
