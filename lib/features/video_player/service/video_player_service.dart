import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/video_player/business_objects/video_player_controller_data_bo.dart';
import 'package:pssn/features/video_player/datasources/local/video_player_local_data_source.dart';

abstract class VideoPlayerService {
  Stream<Result<VideoPlayerControllerDataBO>> get dataStreamController;

  Future<void> init();

  Future<void> dispose();

  Future<void> play();

  Future<void> pause();

  Future<void> togglePause();

  Future<void> seekTo(Duration duration);

  Future<void> setVolume(double volume);

  Future<void> enterFullScreen();

  Future<void> exitFullScreen();

  Future<void> toggleFullScreen();
}

class DefaultVideoPlayerService implements VideoPlayerService {
  DefaultVideoPlayerService({
    required this.videoPlayerLocalDataSource,
  });

  final VideoPlayerLocalDataSource videoPlayerLocalDataSource;

  @override
  Stream<Result<VideoPlayerControllerDataBO>> get dataStreamController {
    return videoPlayerLocalDataSource.dataStreamController;
  }

  @override
  Future<void> dispose() {
    return videoPlayerLocalDataSource.dispose();
  }

  @override
  Future<void> init() async {
    return videoPlayerLocalDataSource.init();
  }

  @override
  Future<void> enterFullScreen() async {
    return videoPlayerLocalDataSource.enterFullScreen();
  }

  @override
  Future<void> exitFullScreen() async {
    return videoPlayerLocalDataSource.exitFullScreen();
  }

  @override
  Future<void> pause() async {
    return videoPlayerLocalDataSource.pause();
  }

  @override
  Future<void> play() async {
    return videoPlayerLocalDataSource.play();
  }

  @override
  Future<void> seekTo(Duration duration) async {
    return videoPlayerLocalDataSource.seekTo(duration);
  }

  @override
  Future<void> setVolume(double volume) async {
    return videoPlayerLocalDataSource.setVolume(volume);
  }

  @override
  Future<void> toggleFullScreen() async {
    return videoPlayerLocalDataSource.toggleFullScreen();
  }

  @override
  Future<void> togglePause() async {
    return videoPlayerLocalDataSource.togglePause();
  }
}
