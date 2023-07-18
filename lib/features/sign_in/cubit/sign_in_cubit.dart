import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/authorization/repositories/authorization_service.dart';
import 'package:pssn/features/sign_in/business_objects/credential.dart';
import 'package:pssn/features/sign_in/cubit/sign_in_state.dart';
import 'package:pssn/features/sign_in/repositories/sign_in_service.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    SignInService? signInService,
    AuthorizationService? authorizationService,
  )   : _signInService = signInService ?? getIt(),
        _authorizationService = authorizationService ?? getIt(),
        super(const SignInState.data());

  final SignInService _signInService;
  final AuthorizationService _authorizationService;

  Future<void> signIn(Credential credential, [Map<String, String>? data]) async {
    emit(const SignInState.loading());

    final result = await _signInService.getCredentials(credential, data);

    await result.whenOrNull(
      success: (credentials) =>
          _authorizationService.getRemoteToken(credentials),
    );

    emit(
      result.when(
        success: (_) => const SignInState.data(),
        failed: SignInState.error,
      ),
    );
  }
}
