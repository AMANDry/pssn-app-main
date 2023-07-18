import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) async {
  context.logger
      .info('############### RUN build runner ###############');
  final progress = context.logger.progress(
    'Creating auto generated models using build_runner',
  );
  await Process.run(
    'flutter',
    ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
  ).then((value) {
    print(value.stdout);
    print(value.stderr);
    print(value.exitCode);
  });
  progress.complete();
}
