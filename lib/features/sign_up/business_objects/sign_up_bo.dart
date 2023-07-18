import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_bo.freezed.dart';

@freezed
class SignUpBO with _$SignUpBO {
  const factory SignUpBO({
    required String email,
    required String password,
  }) = _SignUpBO;
}
