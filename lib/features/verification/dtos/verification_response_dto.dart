import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/verification/business_objects/verification_response_bo.dart';

part 'verification_response_dto.freezed.dart';

part 'verification_response_dto.g.dart';

@freezed
class VerificationResponseDTO with _$VerificationResponseDTO {
  const factory VerificationResponseDTO({
    @Default(false) bool isVerified,
  }) = _VerificationResponseDTO;

  const VerificationResponseDTO._();

  VerificationResponseBO toBO() => VerificationResponseBO(isVerified);

  factory VerificationResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$VerificationResponseDTOFromJson(json);
}
