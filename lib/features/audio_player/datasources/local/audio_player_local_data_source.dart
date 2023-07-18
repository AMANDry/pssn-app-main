import 'dart:async';

import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/audio_player/business_objects/audio_player_controller_data_bo.dart';

abstract class AudioPlayerLocalDataSource {
  Stream<Result<AudioPlayerControllerDataBO>> get dataStreamController;

  Future<void> init();

  Future<void> play();

  Future<void> pause();

  Future<void> togglePause();

  Future<void> seekTo(Duration duration);

  Future<void> setVolume(double volume);

  Future<void> dispose();
}
