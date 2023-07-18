import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/journey/cubit/journey_state.dart';
import 'package:pssn/features/journey/repositories/journey_repository.dart';

class JourneyCubit extends Cubit<JourneyState> {
  JourneyCubit(JourneyRepository? journeyRepository)
      : _journeyRepository = journeyRepository ?? getIt.get(),
        super(const JourneyState.loading());

  final JourneyRepository _journeyRepository;

  Future<void> getJourney() async {
    emit(const JourneyState.loading());

    final result = await _journeyRepository.getJourney();

    emit(
      result.when(
        success: JourneyState.data,
        failed: JourneyState.error,
      ),
    );
  }

  Future<void> newJourney() async {
    emit(const JourneyState.loading());

    final result = await _journeyRepository.newJourney();

    emit(
      result.when(
        success: JourneyState.data,
        failed: JourneyState.error,
      ),
    );
  }

}
