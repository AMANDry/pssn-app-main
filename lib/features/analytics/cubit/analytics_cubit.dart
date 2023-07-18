import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/analytics/cubit/analytics_state.dart';
import 'package:pssn/features/analytics/repositories/analytics_service.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit(AnalyticsService? analyticsRepository)
      : _analyticsService = analyticsRepository ?? getIt.get(),
        super(const AnalyticsState.loading());

  final AnalyticsService _analyticsService;

  Future<void> logCustomEvent(String name) async {
    emit(const AnalyticsState.loading());

    final result = await _analyticsService.logCustomEvent(name);

    emit(
      result.when(
        success: (_) => const AnalyticsState.data(),
        failed: (exception) => AnalyticsState.error(exception),
      ),
    );
  }

  Future<void> logScreenView(String name) async {
    emit(const AnalyticsState.loading());

    final result = await _analyticsService.logScreenView(name);

    emit(
      result.when(
        success: (_) => const AnalyticsState.data(),
        failed: (exception) => AnalyticsState.error(exception),
      ),
    );
  }
}
