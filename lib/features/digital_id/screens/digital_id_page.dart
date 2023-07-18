import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/digital_id/business_objects/digital_id_bo.dart';
import 'package:pssn/features/digital_id/cubit/digital_id_cubit.dart';
import 'package:pssn/features/digital_id/cubit/digital_id_state.dart';
import 'package:pssn/features/digital_id/datasources/api/digital_id_api.dart';
import 'package:pssn/features/digital_id/datasources/remote/default_digital_id_remote_data_source.dart';
import 'package:pssn/features/digital_id/repositories/digital_id_repository.dart';

class DigitalIdPage extends StatelessWidget {
  const DigitalIdPage({super.key});

  static const path = 'digitalid';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DigitalIdCubit>(
      create: (_) {
        final digitalIdApi = DigitalIdApi(getIt());
        final digitalIdRemoteDataSource =
            DefaultDigitalIdRemoteDataSource(digitalIdApi);

        final digitalIdRepository = DefaultDigitalIdRepository(
          remoteDataSource: digitalIdRemoteDataSource,
        );
        return DigitalIdCubit(digitalIdRepository)..getDigitalId();
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<DigitalIdCubit, DigitalIdState>(
                  builder: (_, DigitalIdState state) {
                    return state.when(
                      loading: () => const CircularProgressIndicator(),
                      data: (bo) => _DigitalIdWidget(digitalIdBO: bo),
                      error: (exception) => Text(exception.message),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DigitalIdWidget extends StatelessWidget {
  const _DigitalIdWidget({required this.digitalIdBO});

  final DigitalIdBO digitalIdBO;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(digitalIdBO.id.toString()),
        const SizedBox(height: 50),
        Text(digitalIdBO.name),
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () => context.read<DigitalIdCubit>().createDigitalId(
                const DigitalIdBO(id: 2, name: 'Test user 2'),
              ),
          child: const Text('POST digitalid'),
        ),
      ],
    );
  }
}
