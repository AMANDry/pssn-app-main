import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/verification/business_objects/verification_bo.dart';
import 'package:pssn/features/verification/cubit/verification_state.dart';
import 'package:pssn/features/verification/repositories/verification_repository.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(VerificationRepository? verificationRepository)
      : _verificationRepository = verificationRepository ?? getIt.get(),
        super(const VerificationState.data());

  final VerificationRepository _verificationRepository;

  Future<void> verification(VerificationBO verificationBO) async {
    emit(const VerificationState.loading());

    final result = await _verificationRepository.verification(verificationBO);

    emit(
      result.when(
        success: (bo) {
          return VerificationState.data(isVerified: bo.isVerified);
        },
        failed: VerificationState.error,
      ),
    );
  }
}
