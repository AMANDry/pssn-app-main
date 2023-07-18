import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  AppLifecycleObserver({this.onResumed});

  final AsyncCallback? onResumed;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await onResumed?.call();
        break;
      default:
        break;
    }
  }
}
