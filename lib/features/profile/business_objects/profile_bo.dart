import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_bo.freezed.dart';

@freezed
class ProfileBO with _$ProfileBO {
  const factory ProfileBO(
    String id, {
    required String fullName,
    required String imageUrl,
  }) = _ProfileBO;
}
