import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/verification/business_objects/verification_bo.dart';

part 'verification_dto.freezed.dart';

part 'verification_dto.g.dart';

@freezed
class VerificationDTO with _$VerificationDTO {
  const factory VerificationDTO({@Default('') String verifyCode}) =
      _VerificationDTO;

  const VerificationDTO._();

  VerificationBO toBo() => VerificationBO(verifyCode);

  factory VerificationDTO.fromBo(VerificationBO verificationBO) =>
      VerificationDTO(verifyCode: verificationBO.verifyCode);

  factory VerificationDTO.fromJson(Map<String, dynamic> json) =>
      _$VerificationDTOFromJson(json);
}
