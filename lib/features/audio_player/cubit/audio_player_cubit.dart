import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/audio_player/business_objects/audio_player_controller_data_bo.dart';
import 'package:pssn/features/audio_player/cubit/audio_player_state.dart';
import 'package:pssn/features/audio_player/service/audio_player_service.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit({
    required AudioPlayerService audioPlayerService,
  })  : _audioPlayerService = audioPlayerService,
        super(const AudioPlayerState.loading()) {
    _init();
  }

  final AudioPlayerService _audioPlayerService;
  late StreamSubscription subscription;

  void _init() {
    _audioPlayerService.init();
    subscription = _audioPlayerService.dataStreamController.listen((event) {
      _onAudioPlayerData(resultAudioPlayerControllerDataBO: event);
    });
  }

  void _onAudioPlayerData({
    required Result<AudioPlayerControllerDataBO>
        resultAudioPlayerControllerDataBO,
  }) {
    emit(
      resultAudioPlayerControllerDataBO.map(
        success: (state) {
          if (state.data.isPlaying) {
            return AudioPlayerState.isPlaying(
              startAt: state.data.startAt,
              volume: state.data.volume,
            );
          } else {
            return AudioPlayerState.isPaused(
              startAt: state.data.startAt,
              volume: state.data.volume,
            );
          }
        },
        failed: (state) => AudioPlayerState.error(state.exception),
      ),
    );
  }

  Future<void> pause() async {
    return _audioPlayerService.pause();
  }

  Future<void> play() async {
    return _audioPlayerService.play();
  }

  Future<void> seekTo(Duration duration) async {
    return _audioPlayerService.seekTo(duration);
  }

  Future<void> setVolume(double volume) async {
    return _audioPlayerService.setVolume(volume);
  }

  Future<void> togglePause() async {
    return _audioPlayerService.togglePause();
  }

  @override
  Future<void> close() async {
    _audioPlayerService.dispose();
    subscription.cancel();
    return super.close();
  }
}
