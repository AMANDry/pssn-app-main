import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_bo.freezed.dart';

@freezed
class VerificationBO with _$VerificationBO {
  const factory VerificationBO(String verifyCode) = _VerificationBO;
}
