import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/widgets/text_field_wrapper.dart';
import 'package:pssn/features/sign_in/screens/sign_in_page.dart';
import 'package:pssn/features/sign_up/business_objects/sign_up_bo.dart';
import 'package:pssn/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:pssn/features/sign_up/cubit/sign_up_state.dart';
import 'package:pssn/features/sign_up/datasources/api/sign_up_api.dart';
import 'package:pssn/features/sign_up/datasources/remote/default_sign_up_remote_data_source.dart';
import 'package:pssn/features/sign_up/repositories/sign_up_repository.dart';
import 'package:pssn/features/verification/screens/verification_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const path = "sign-up";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) {
        final signUpApi = SignUpApi(getIt());

        final signUpRemoteDataSource = DefaultSignUpRemoteDataSource(signUpApi);

        final signUpRepository = DefaultSignUpRepository(
          remoteDataSource: signUpRemoteDataSource,
        );
        return SignUpCubit(signUpRepository);
      },
      child: Scaffold(
        body: Center(
          child: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (_, SignUpState state) {
              return state.when(
                loading: () => const CircularProgressIndicator(),
                data: () => const _SignUpWidget(),
                error: (exception) => Text(exception.message),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SignUpWidget extends StatefulWidget {
  const _SignUpWidget();



  @override
  State<_SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<_SignUpWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? password;
  String? confPassword;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 300.w,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldWrapper(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (text) => email = text,
                  ),
                  TextFieldWrapper(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    labelText: 'Password',
                    obscureText: true,
                    onChanged: (text) => password = text,
                  ),
                  TextFieldWrapper(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm password';
                      } else if (password != confPassword) {
                        return "Your password doesn't mach";
                      }
                      return null;
                    },
                    labelText: 'Confirm Password',
                    obscureText: true,
                    onChanged: (text) => confPassword = text,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignUpCubit>().signUp(
                              SignUpBO(email: email!, password: password!),
                            );
                        GoRouter.of(context).go('${SignInPage.path}/${SignUpPage.path}/${VerificationPage.path}');
                      }
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
