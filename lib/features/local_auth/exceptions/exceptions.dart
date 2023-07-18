import 'package:pssn/common/exceptions/app_exceptions.dart';

class AppLocalAuthException extends AppException {
  AppLocalAuthException(super.message, this.code);

  final String code;

  @override
  String toString() {
    return message;
  }

  /// Indicates that the user has not yet configured a passcode (iOS) or
  /// PIN/pattern/password (Android) on the device.
  static const String passcodeNotSet = 'PasscodeNotSet';

  /// Indicates the user has not enrolled any biometrics on the device.
  static const String notEnrolled = 'NotEnrolled';

  /// Indicates the device does not have hardware support for biometrics.
  static const String notAvailable = 'NotAvailable';

  /// Indicates the device operating system is unsupported.
  static const String otherOperatingSystem = 'OtherOperatingSystem';

  /// Indicates the API is temporarily locked out due to too many attempts.
  static const String lockedOut = 'LockedOut';

  /// Indicates the API is locked out more persistently than [lockedOut].
  /// Strong authentication like PIN/Pattern/Password is required to unlock.
  static const String permanentlyLockedOut = 'PermanentlyLockedOut';

  /// Indicates that the biometricOnly parameter can't be true on Windows
  static const String biometricOnlyNotSupported = 'biometricOnlyNotSupported';
}
