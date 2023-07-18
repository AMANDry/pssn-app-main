import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/helpers/logging_mixin.dart';

class AppBlocObserver extends BlocObserver with AppLoggingMixin {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    printInfo('${bloc.runtimeType} has a new state:\n${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    printError(
      '${bloc.runtimeType} has a new error:\n${error.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
