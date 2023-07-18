import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/video_player/business_objects/video_player_controller_data_bo.dart';
import 'package:pssn/features/video_player/datasources/local/video_player_local_data_source.dart';
import 'package:pssn/features/video_player/exceptions/app_video_controller_initialization_exception.dart';

class DefaultVideoPlayerLocalDataSource implements VideoPlayerLocalDataSource {
  final ChewieController chewieController;
  final StreamController<Result<VideoPlayerControllerDataBO>>
      _dataStreamController = StreamController.broadcast();

  DefaultVideoPlayerLocalDataSource({required this.chewieController}) {
    chewieController.videoPlayerController.addListener(() {
      _onChewieControllerChanged();
    });
  }

  void _onChewieControllerChanged() {
    _dataStreamController.add(_fetchCurrentStateFromVideoController());
  }

  Result<VideoPlayerControllerDataBO> _fetchCurrentStateFromVideoController() {
    return Result.success(
      VideoPlayerControllerDataBO(
        isPlaying: chewieController.isPlaying,
        isFullScreen: chewieController.isFullScreen,
        startAt: chewieController.startAt,
        aspectRatio: chewieController.videoPlayerController.value.aspectRatio,
        volume: chewieController.videoPlayerController.value.volume,
      ),
    );
  }

  @override
  Stream<Result<VideoPlayerControllerDataBO>> get dataStreamController =>
      _dataStreamController.stream;

  @override
  Future<void> dispose() async {
    _dataStreamController.close();
    chewieController.removeListener(_onChewieControllerChanged);
  }

  @override
  Future<void> init() async {
    try {
      await chewieController.videoPlayerController.initialize();
    } catch (error) {
      _dataStreamController.add(
        Result.failed(
          AppVideoControllerInitializationException(error.toString()),
        ),
      );
    }
  }

  @override
  Future<void> enterFullScreen() async {
    return chewieController.enterFullScreen();
  }

  @override
  Future<void> exitFullScreen() async {
    return chewieController.exitFullScreen();
  }

  @override
  Future<void> pause() async {
    return chewieController.pause();
  }

  @override
  Future<void> play() async {
    return chewieController.play();
  }

  @override
  Future<void> seekTo(Duration duration) async {
    return chewieController.seekTo(duration);
  }

  @override
  Future<void> setVolume(double volume) async {
    return chewieController.setVolume(volume);
  }

  @override
  Future<void> toggleFullScreen() async {
    return chewieController.toggleFullScreen();
  }

  @override
  Future<void> togglePause() async {
    return chewieController.togglePause();
  }
}
