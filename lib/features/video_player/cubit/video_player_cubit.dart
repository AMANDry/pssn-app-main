import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/video_player/business_objects/video_player_controller_data_bo.dart';
import 'package:pssn/features/video_player/cubit/video_player_state.dart';
import 'package:pssn/features/video_player/service/video_player_service.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit({
    required VideoPlayerService videoPlayerService,
  })  : _videoPlayerService = videoPlayerService,
        super(const VideoPlayerState.loading()) {
    _init();
  }

  final VideoPlayerService _videoPlayerService;
  late StreamSubscription subscription;

  void _init() {
    _videoPlayerService.init();
    subscription = _videoPlayerService.dataStreamController.listen((event) {
      _onVideoPlayerData(resultVideoPlayerControllerDataBO: event);
    });
  }

  void _onVideoPlayerData({
    required Result<VideoPlayerControllerDataBO>
        resultVideoPlayerControllerDataBO,
  }) {
    emit(
      resultVideoPlayerControllerDataBO.map(
        success: (state) {
          if (state.data.isPlaying) {
            return VideoPlayerState.isPlaying(
              isFullScreen: state.data.isFullScreen,
              startAt: state.data.startAt,
              volume: state.data.volume,
            );
          } else {
            return VideoPlayerState.isPaused(
              isFullScreen: state.data.isFullScreen,
              startAt: state.data.startAt,
              volume: state.data.volume,
            );
          }
        },
        failed: (state) => VideoPlayerState.error(state.exception),
      ),
    );
  }

  Future<void> enterFullScreen() async {
    return _videoPlayerService.enterFullScreen();
  }

  Future<void> exitFullScreen() async {
    return _videoPlayerService.exitFullScreen();
  }

  Future<void> pause() async {
    return _videoPlayerService.pause();
  }

  Future<void> play() async {
    return _videoPlayerService.play();
  }

  Future<void> seekTo(Duration duration) async {
    return _videoPlayerService.seekTo(duration);
  }

  Future<void> setVolume(double volume) async {
    return _videoPlayerService.setVolume(volume);
  }

  Future<void> toggleFullScreen() async {
    return _videoPlayerService.toggleFullScreen();
  }

  Future<void> togglePause() async {
    return _videoPlayerService.togglePause();
  }

  @override
  Future<void> close() async {
    _videoPlayerService.dispose();
    subscription.cancel();
    return super.close();
  }
}
