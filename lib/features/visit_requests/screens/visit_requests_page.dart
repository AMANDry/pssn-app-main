import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/visit_requests/cubit/visit_requests_cubit.dart';
import 'package:pssn/features/visit_requests/cubit/visit_requests_state.dart';
import 'package:pssn/features/visit_requests/datasources/api/visit_requests_api.dart';
import 'package:pssn/features/visit_requests/datasources/remote/default_visit_requests_remote_data_source.dart';
import 'package:pssn/features/visit_requests/repositories/visit_requests_repository.dart';

class VisitRequestsPage extends StatelessWidget {
  const VisitRequestsPage({super.key});

  static const path = "visit-requests";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VisitRequestsCubit>(
      create: (_) {
        final visitRequestsApi = VisitRequestsApi(getIt());
        final visitRequestsRemoteDataSource =
            DefaultVisitRequestsRemoteDataSource(visitRequestsApi);

        final visitRequestsRepository = DefaultVisitRequestsRepository(
          remoteDataSource: visitRequestsRemoteDataSource,
        );
        return VisitRequestsCubit(visitRequestsRepository)
          ..createVisitRequests();
      },
      child: Scaffold(
        body: Center(
          child: BlocBuilder<VisitRequestsCubit, VisitRequestsState>(
            builder: (_, VisitRequestsState state) {
              return state.when(
                loading: () => const CircularProgressIndicator(),
                data: (bo) => _VisitRequestsWidget(bo.id.toString()),
                error: (exception) => Text(exception.message),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _VisitRequestsWidget extends StatelessWidget {
  const _VisitRequestsWidget(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () =>
                    context.read<VisitRequestsCubit>().getVisitRequests(),
                child: const Text('Get'),
              ),
              ElevatedButton(
                onPressed: () =>
                    context.read<VisitRequestsCubit>().createVisitRequests(),
                child: const Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
