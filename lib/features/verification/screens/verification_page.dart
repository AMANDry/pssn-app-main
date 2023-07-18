import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/verification/business_objects/verification_bo.dart';
import 'package:pssn/features/verification/cubit/verification_cubit.dart';
import 'package:pssn/features/verification/cubit/verification_state.dart';
import 'package:pssn/features/verification/datasources/api/verification_api.dart';
import 'package:pssn/features/verification/datasources/remote/default_verification_remote_data_source.dart';
import 'package:pssn/features/verification/repositories/verification_repository.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key, required this.navigation});

  final String navigation;
  static const path = "verification";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerificationCubit>(
      create: (_) {
        final verificationApi = VerificationApi(getIt());
        final verificationRemoteDataSource =
            DefaultVerificationRemoteDataSource(verificationApi);
        final verificationRepository = DefaultVerificationRepository(
          remoteDataSource: verificationRemoteDataSource,
        );
        return VerificationCubit(verificationRepository);
      },
      child: Scaffold(
        body: Center(
          child: BlocConsumer<VerificationCubit, VerificationState>(
            listener: (context, state) {
              state.whenOrNull(
                data: (isVerified) {
                  if (isVerified) {
                    GoRouter.of(context).go(navigation);
                  }
                },
              );
            },
            listenWhen: (previous, current) =>
                previous != current && current is Data && current.isVerified,
            builder: (_, state) {
              return state.when(
                loading: () => const CircularProgressIndicator(),
                data: (isVerified) => const _VerificationWidget(),
                error: (exception) => Text(exception.message),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _VerificationWidget extends StatefulWidget {
  const _VerificationWidget();

  @override
  State<_VerificationWidget> createState() => _VerificationWidgetState();
}

class _VerificationWidgetState extends State<_VerificationWidget> {

  @override
  void initState() {
    super.initState();
    _listenSmsCode();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  Future<void> _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }

  String verifyCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 300.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PinFieldAutoFill(
                  autoFocus: true,
                  decoration: UnderlineDecoration(
                    lineStrokeCap: StrokeCap.square,
                    bgColorBuilder: PinListenColorBuilder(
                      Colors.green.shade200,
                      Colors.grey.shade200,
                    ),
                    colorBuilder: const FixedColorBuilder(Colors.transparent),
                  ),
                  onCodeChanged: (value) {
                    verifyCode = value ?? '';
                  },
                ),
                TextButton(
                  onPressed: () {
                    if (verifyCode.length == 6) {
                      context.read<VerificationCubit>().verification(
                            VerificationBO(verifyCode),
                          );
                    }
                  },
                  child: const Text("Confirm"),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Resend Code"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
