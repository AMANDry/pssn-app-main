import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/journey/cubit/journey_cubit.dart';
import 'package:pssn/features/journey/cubit/journey_state.dart';
import 'package:pssn/features/journey/datasources/api/journey_api.dart';
import 'package:pssn/features/journey/datasources/remote/default_journey_remote_data_source.dart';
import 'package:pssn/features/journey/repositories/journey_repository.dart';

class JourneyPage extends StatelessWidget {
  const JourneyPage({super.key});

  static const path = 'journey';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JourneyCubit>(
      create: (_) {
        final journeyApi = JourneyApi(getIt());
        final journeyRemoteDataSource =
            DefaultJourneyRemoteDataSource(journeyApi);

        final journeyRepository = DefaultJourneyRepository(
          remoteDataSource: journeyRemoteDataSource,
        );
        return JourneyCubit(journeyRepository)..getJourney();
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: BlocBuilder<JourneyCubit, JourneyState>(
              builder: (_, JourneyState state) {
                return state.when(
                  loading: () => const CircularProgressIndicator(),
                  data: (bo) => _JourneyWidget(bo.id.toString()),
                  error: (exception) => Text(exception.message),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _JourneyWidget extends StatelessWidget {
  const _JourneyWidget(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        ElevatedButton(
          onPressed: () => context.read<JourneyCubit>().newJourney(),
          child: const Text('New Journey'),
        ),
      ],
    );
  }
}
