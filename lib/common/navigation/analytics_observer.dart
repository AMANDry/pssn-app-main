import 'package:flutter/material.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/helpers/logging_mixin.dart';
import 'package:pssn/features/analytics/repositories/analytics_service.dart';

class AnalyticsObserver extends NavigatorObserver with AppLoggingMixin {
  AnalyticsObserver(AnalyticsService? analyticsService)
      : _analyticsService = analyticsService ?? getIt();

  final AnalyticsService _analyticsService;

  void _logScreenView(String? screenName) {
    if (screenName != null) {
      _analyticsService.logScreenView(screenName);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    printDebug('Pushed ${route.settings.name}');
    _logScreenView(route.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    printDebug(
      'Poped to ${previousRoute?.settings.name} from ${route.settings.name}',
    );
    if (previousRoute != null) {
      _logScreenView(previousRoute.settings.name);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    printDebug(
      'Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}',
    );
    if (newRoute != null) {
      _logScreenView(newRoute.settings.name);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    printDebug('Removed ${route.settings.name}');
  }
}
