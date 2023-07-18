import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/visit_requests/cubit/visit_requests_state.dart';
import 'package:pssn/features/visit_requests/repositories/visit_requests_repository.dart';

class VisitRequestsCubit extends Cubit<VisitRequestsState> {
  VisitRequestsCubit(VisitRequestsRepository? visitRequestsRepository)
      : _visitRequestsRepository = visitRequestsRepository ?? getIt.get(),
        super(const VisitRequestsState.loading());

  final VisitRequestsRepository _visitRequestsRepository;

  Future<void> getVisitRequests() async {
    emit(const VisitRequestsState.loading());

    final result = await _visitRequestsRepository.getVisitRequests();

    emit(
      result.when(
        success: VisitRequestsState.data,
        failed: VisitRequestsState.error,
      ),
    );
  }

  Future<void> createVisitRequests() async {
    emit(const VisitRequestsState.loading());

    final result = await _visitRequestsRepository.createVisitRequests();

    emit(
      result.when(
        success: VisitRequestsState.data,
        failed: VisitRequestsState.error,
      ),
    );
  }
}
