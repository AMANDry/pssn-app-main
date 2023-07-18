import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/features/sign_up/business_objects/sign_up_bo.dart';

part 'sign_up_dto.freezed.dart';

part 'sign_up_dto.g.dart';

@freezed
class SignUpDTO with _$SignUpDTO {
  const factory SignUpDTO({
    @Default('email') String email,
    @Default('password') String password,
  }) = _SignUpDTO;

  const SignUpDTO._();

  SignUpBO toBo() => SignUpBO(email: email, password: password);

  factory SignUpDTO.fromJson(Map<String, dynamic> json) =>
      _$SignUpDTOFromJson(json);
}
