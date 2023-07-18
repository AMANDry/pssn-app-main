import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';

part 'audio_player_state.freezed.dart';

@freezed
class AudioPlayerState with _$AudioPlayerState {
  const factory AudioPlayerState.loading() = _Loading;

  const factory AudioPlayerState.isPlaying({
    required Duration? startAt,
    required double volume,
  }) = _IsPlaying;

  const factory AudioPlayerState.isPaused({
    required Duration? startAt,
    required double volume,
  }) = _IsPaused;

  const factory AudioPlayerState.error(AppException error) = _Error;
}
