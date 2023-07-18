import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/digital_id/business_objects/digital_id_bo.dart';
import 'package:pssn/features/digital_id/cubit/digital_id_state.dart';
import 'package:pssn/features/digital_id/repositories/digital_id_repository.dart';

class DigitalIdCubit extends Cubit<DigitalIdState> {
  DigitalIdCubit(DigitalIdRepository? digitalIdRepository)
      : _digitalIdRepository = digitalIdRepository ?? getIt.get(),
        super(const DigitalIdState.loading());

  final DigitalIdRepository _digitalIdRepository;

  Future<void> getDigitalId() async {
    emit(const DigitalIdState.loading());

    final result = await _digitalIdRepository.getDigitalId();

    emit(
      result.when(
        success: DigitalIdState.data,
        failed: DigitalIdState.error,
      ),
    );
  }

  Future<void> createDigitalId(DigitalIdBO digitalIdBO) async {
    emit(const DigitalIdState.loading());

    final result = await _digitalIdRepository.createDigitalId(digitalIdBO);

    emit(
      result.when(
        success: DigitalIdState.data,
        failed: DigitalIdState.error,
      ),
    );
  }
}
