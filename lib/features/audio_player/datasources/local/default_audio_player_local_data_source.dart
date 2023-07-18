import 'dart:async';

import 'package:chewie_audio/chewie_audio.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/audio_player/business_objects/audio_player_controller_data_bo.dart';
import 'package:pssn/features/audio_player/datasources/local/audio_player_local_data_source.dart';
import 'package:pssn/features/audio_player/exceptions/app_video_controller_initialization_exception.dart';

class DefaultAudioPlayerLocalDataSource implements AudioPlayerLocalDataSource {
  final ChewieAudioController chewieAudioController;
  final StreamController<Result<AudioPlayerControllerDataBO>>
      _dataStreamController = StreamController.broadcast();

  DefaultAudioPlayerLocalDataSource({required this.chewieAudioController}) {
    chewieAudioController.videoPlayerController.addListener(() {
      _onChewieAudioControllerChanged();
    });
  }

  void _onChewieAudioControllerChanged() {
    _dataStreamController.add(_fetchCurrentStateFromVideoController());
  }

  Result<AudioPlayerControllerDataBO> _fetchCurrentStateFromVideoController() {
    return Result.success(
      AudioPlayerControllerDataBO(
        isPlaying: chewieAudioController.isPlaying,
        startAt: chewieAudioController.startAt,
        volume: chewieAudioController.videoPlayerController.value.volume,
      ),
    );
  }

  @override
  Stream<Result<AudioPlayerControllerDataBO>> get dataStreamController =>
      _dataStreamController.stream;

  @override
  Future<void> dispose() async {
    _dataStreamController.close();
    chewieAudioController.removeListener(_onChewieAudioControllerChanged);
  }

  @override
  Future<void> init() async {
    try {
      await chewieAudioController.videoPlayerController.initialize();
    } catch (error) {
      _dataStreamController.add(
        Result.failed(
          AppVideoControllerInitializationException(error.toString()),
        ),
      );
    }
  }

  @override
  Future<void> pause() async {
    return chewieAudioController.pause();
  }

  @override
  Future<void> play() async {
    return chewieAudioController.play();
  }

  @override
  Future<void> seekTo(Duration duration) async {
    return chewieAudioController.seekTo(duration);
  }

  @override
  Future<void> setVolume(double volume) async {
    return chewieAudioController.setVolume(volume);
  }

  @override
  Future<void> togglePause() async {
    return chewieAudioController.togglePause();
  }
}
