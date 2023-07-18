import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/sign_up/business_objects/sign_up_bo.dart';
import 'package:pssn/features/sign_up/cubit/sign_up_state.dart';
import 'package:pssn/features/sign_up/repositories/sign_up_repository.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(SignUpRepository? signUpRepository)
      : _signUpRepository = signUpRepository ?? getIt.get(),
        super(const SignUpState.data());

  final SignUpRepository _signUpRepository;

  Future<void> signUp(SignUpBO signUpBO) async {
    emit(const SignUpState.loading());

    final result = await _signUpRepository.signUp(signUpBO);

    emit(
      result.when(
        success: (data) => const SignUpState.data(),
        failed: SignUpState.error,
      ),
    );
  }
}
