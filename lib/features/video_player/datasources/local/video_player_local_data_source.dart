import 'dart:async';

import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/video_player/business_objects/video_player_controller_data_bo.dart';

abstract class VideoPlayerLocalDataSource {
  Stream<Result<VideoPlayerControllerDataBO>> get dataStreamController;

  Future<void> init();

  Future<void> play();

  Future<void> pause();

  Future<void> togglePause();

  Future<void> seekTo(Duration duration);

  Future<void> setVolume(double volume);

  Future<void> enterFullScreen();

  Future<void> exitFullScreen();

  Future<void> toggleFullScreen();

  Future<void> dispose();
}
