import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_cubit.dart';
import 'package:pssn/features/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_state.dart';
import 'package:pssn/features/{{name.snakeCase()}}/datasources/api/{{name.snakeCase()}}_api.dart';
import 'package:pssn/features/{{name.snakeCase()}}/datasources/local/default_{{name.snakeCase()}}_local_data_source.dart';
import 'package:pssn/features/{{name.snakeCase()}}/datasources/remote/default_{{name.snakeCase()}}_remote_data_source.dart';
import 'package:pssn/features/{{name.snakeCase()}}/repositories/{{name.snakeCase()}}_repository.dart';

class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({super.key});

  static const path = "{{name.paramCase()}}";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<{{name.pascalCase()}}Cubit>(
      create: (_) {
        final {{name.camelCase()}}Api = {{name.pascalCase()}}Api(getIt());
        final {{name.camelCase()}}LocalDataSource = Default{{name.pascalCase()}}LocalDataSource(getIt());
        final {{name.camelCase()}}RemoteDataSource =
            Default{{name.pascalCase()}}RemoteDataSource({{name.camelCase()}}Api);

        final {{name.camelCase()}}Repository = Default{{name.pascalCase()}}Repository(
          localDataSource: {{name.camelCase()}}LocalDataSource,
          remoteDataSource: {{name.camelCase()}}RemoteDataSource,
        );
        return {{name.pascalCase()}}Cubit({{name.camelCase()}}Repository);
      },
      child: Scaffold(
        body: BlocBuilder<{{name.pascalCase()}}Cubit, {{name.pascalCase()}}State>(
          builder: (_, {{name.pascalCase()}}State state) {
            return state.when(
              loading: () => const CircularProgressIndicator(),
              data: (bo) => _{{name.pascalCase()}}Widget(bo.id.toString()),
              error: (exception) => Text(exception.message),
            );
          },
        ),
      ),
    );
  }
}

class _{{name.pascalCase()}}Widget extends StatelessWidget {
  const _{{name.pascalCase()}}Widget(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
