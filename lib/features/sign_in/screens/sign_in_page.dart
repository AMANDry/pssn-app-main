import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/widgets/text_field_wrapper.dart';
import 'package:pssn/features/sign_in/business_objects/credential.dart';
import 'package:pssn/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:pssn/features/sign_in/cubit/sign_in_state.dart';
import 'package:pssn/features/sign_in/datasources/remote/apple_credential_remote_data_source.dart';
import 'package:pssn/features/sign_in/datasources/remote/credential_remote_data_source.dart';
import 'package:pssn/features/sign_in/datasources/remote/email_credential_remote_data_source.dart';
import 'package:pssn/features/sign_in/datasources/remote/facebook_credential_remote_data_source.dart';
import 'package:pssn/features/sign_in/datasources/remote/google_credential_remote_data_source.dart';
import 'package:pssn/features/sign_in/datasources/remote/twitter_credential_remote_data_source.dart';
import 'package:pssn/features/sign_in/repositories/sign_in_service.dart';
import 'package:pssn/features/sign_up/screens/sign_up_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const path = "/sign-in";

  static const availableCredentials = Credential.values;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (_) {
        final credentialDataSources = Map.fromEntries(
          availableCredentials.map((e) {
            CredentialRemoteDataSource dataSource;
            switch (e) {
              case Credential.email:
                dataSource = EmailCredentialRemoteDataSource();
                break;
              case Credential.google:
                dataSource = GoogleCredentialRemoteDataSource(getIt());
                break;
              case Credential.facebook:
                dataSource = FacebookCredentialRemoteDataSource(getIt());
                break;
              case Credential.twitter:
                dataSource = TwitterCredentialRemoteDataSource(getIt());
                break;
              case Credential.apple:
                dataSource = AppleCredentialRemoteDataSource();
                break;
            }
            return MapEntry(e, dataSource);
          }),
        );
        final signInService = DefaultSignInService(
          credentialDataSources: credentialDataSources,
        );
        return SignInCubit(signInService, getIt());
      },
      child: Scaffold(
        body: Center(
          child: BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) => state.whenOrNull(
              error: (error) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    error.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            builder: (_, SignInState state) {
              return state.maybeWhen(
                loading: () => const CircularProgressIndicator(),
                orElse: () => const _SignInWidget(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SignInWidget extends StatelessWidget {
  const _SignInWidget();

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...SignInPage.availableCredentials.map(
            (e) => e == Credential.email ? _EmailWidget() : _OtherWidget(e),
          ),
          OutlinedButton(
            onPressed: () => GoRouter.of(context)
                .go('${SignInPage.path}/${SignUpPage.path}'),
            child: const Text('Sign Up'),
          ),
        ],
      );
}

class _EmailWidget extends StatelessWidget {
  final Map<String, String> _fields = {};
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: SizedBox(
          width: 300.sp,
          child: Column(
            children: [
              TextFieldWrapper(
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                // TODO Add onSaved after merged
                validator: (text) =>
                    (text == null || text.isEmpty) ? 'Empty' : null,
              ),
              TextFieldWrapper(
                labelText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (text) =>
                    (text == null || text.isEmpty) ? 'Empty' : null,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  _formKey.currentState?.save();
                  context.read<SignInCubit>().signIn(
                        Credential.email,
                        _fields,
                      );
                },
                child: const Text('Sign in'),
              ),
            ],
          ),
        ),
      );
}

class _OtherWidget extends StatelessWidget {
  const _OtherWidget(this.credential);

  final Credential credential;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () => context.read<SignInCubit>().signIn(credential),
        child: Text(toBeginningOfSentenceCase(credential.name) ?? ''),
      );
}
