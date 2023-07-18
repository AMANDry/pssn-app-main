import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_response_bo.freezed.dart';

@freezed
class VerificationResponseBO with _$VerificationResponseBO {
  // ignore: avoid_positional_boolean_parameters
  const factory VerificationResponseBO(bool isVerified) =
      _VerificationResponseBO;
}
