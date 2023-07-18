import 'package:pssn/common/exceptions/app_exceptions.dart';

class AppLocationException extends AppException {
  AppLocationException(super.message, this.code);

  final String code;

  @override
  String toString() {
    return message;
  }

  static const String permissionDenied = "PermissionDenied";

  static const String serviceDisabled = "ServiceDisabled";
}
