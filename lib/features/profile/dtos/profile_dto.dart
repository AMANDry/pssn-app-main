import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/profile/business_objects/profile_bo.dart';

part 'profile_dto.freezed.dart';
part 'profile_dto.g.dart';

@freezed
class ProfileDTO with _$ProfileDTO {
  const factory ProfileDTO({
    @Default('0') String id,
    @Default('') String fullName,
    @Default('') String imageUrl,
  }) = _ProfileDTO;

  const ProfileDTO._();

  ProfileBO toBo() => ProfileBO(
        id,
        fullName: fullName,
        imageUrl: imageUrl,
      );

  factory ProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$ProfileDTOFromJson(json);
}
