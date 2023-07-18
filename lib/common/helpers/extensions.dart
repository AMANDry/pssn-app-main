import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';

extension FutureToResultExtension<T> on Future<T> {
  Future<Result<R>> toResult<R>({R Function(T value)? mapper}) async {
    try {
      if (mapper != null) {
        return Result<R>.success(mapper(await this));
      } else if (R == T) {
        return Result<R>.success(await this as R);
      } else {
        return Result<R>.failed(
          AppUnknownException('Result type exception'),
        );
      }
    } catch (exception, stackTrace) {
      final Logger logger = getIt();
      logger.e('ToResult Error', exception, stackTrace);

      return Result<R>.failed(
        AppUnknownException('Unknown exception'),
      );
    }
  }
}

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  AppLocalizations get localization => AppLocalizations.of(this)!;
}

extension StringExtensions on String {
  String throttled({int limit = 50}) {
    return substring(0, length < limit ? length : limit) +
        (length < limit ? '' : '...(more)');
  }
}
