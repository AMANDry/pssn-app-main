import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_state.dart';
import 'package:pssn/features/{{name.snakeCase()}}/repositories/{{name.snakeCase()}}_repository.dart';

class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State> {
  {{name.pascalCase()}}Cubit({{name.pascalCase()}}Repository? {{name.camelCase()}}Repository)
      : _{{name.camelCase()}}Repository = {{name.camelCase()}}Repository ?? getIt.get(),
        super(const {{name.pascalCase()}}State.loading());

  final {{name.pascalCase()}}Repository _{{name.camelCase()}}Repository;

  Future<void> get{{name.pascalCase()}}() async {
    emit(const {{name.pascalCase()}}State.loading());

    final result = await _{{name.camelCase()}}Repository.get{{name.pascalCase()}}();

    emit(
      result.when(
        success: {{name.pascalCase()}}State.data,
        failed: {{name.pascalCase()}}State.error,
      ),
    );
  }

  @override
  Future<void> close() async {
    return super.close();
  }
}
