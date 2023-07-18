import 'package:logger/logger.dart';
import 'package:pssn/common/di/injections.dart';

mixin AppLoggingMixin {
  final Logger _logger = getIt();

  void printDebug(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error, stackTrace);
  }

  void printInfo(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error, stackTrace);
  }

  void printWarning(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error, stackTrace);
  }

  void printError(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error, stackTrace);
  }
}
