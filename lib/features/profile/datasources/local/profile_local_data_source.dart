import 'dart:io';

import 'package:pssn/common/business_objects/result.dart';

abstract class ProfileLocalDataSource {
  Future<Result<File>> pickupProfileImage();
}
