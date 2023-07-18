import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';
import 'package:pssn/features/profile/datasources/local/profile_local_data_source.dart';

class DefaultProfileLocalDataSource implements ProfileLocalDataSource {
  DefaultProfileLocalDataSource(FilePicker? filePicker)
      : _filePicker = filePicker ?? getIt();

  final FilePicker _filePicker;

  @override
  Future<Result<File>> pickupProfileImage() async {
    final result = await _filePicker.pickFiles(type: FileType.image);
    try {
      if (result != null && result.files.single.path != null) {
        return Result.success(File(result.files.single.path!));
      } else {
        return Result.failed(AppUnknownException("User cancelled file pickup"));
      }
    } catch (exception) {
      return Result.failed(AppUnknownException("Cant pickup file: $exception"));
    }
  }
}
