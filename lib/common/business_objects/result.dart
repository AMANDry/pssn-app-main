import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.success(T data) = ResultSuccess<T>;

  const factory Result.failed(AppException exception) = ResultFailure<T>;
}

Result<bool> combine2Results<T1, T2>(
  Result<T1> result1,
  Result<T2> result2, {
  void Function(T1, T2)? onSuccess,
  void Function(AppException)? onFailure,
}) {
  return result1.when(
    success: (result1) => result2.when(
      success: (result2) {
        onSuccess?.call(result1, result2);
        return const Result.success(true);
      },
      failed: (exception) {
        onFailure?.call(exception);
        return Result.failed(exception);
      },
    ),
    failed: (exception) {
      onFailure?.call(exception);
      return Result.failed(exception);
    },
  );
}

Result<bool> combine3Results<T1, T2, T3>(
  Result<T1> result1,
  Result<T2> result2,
  Result<T3> result3, {
  required void Function(T1, T2, T3)? onSuccess,
  required void Function(AppException)? onFailure,
}) {
  return result1.when(
    success: (result1) {
      return result2.when(
        success: (result2) {
          return result3.when(
            success: (result3) {
              onSuccess?.call(result1, result2, result3);
              return const Result.success(true);
            },
            failed: (exception) {
              onFailure?.call(exception);
              return Result.failed(exception);
            },
          );
        },
        failed: (exception) {
          onFailure?.call(exception);
          return Result.failed(exception);
        },
      );
    },
    failed: (exception) {
      onFailure?.call(exception);
      return Result.failed(exception);
    },
  );
}
