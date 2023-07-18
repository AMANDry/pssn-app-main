import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pssn/common/exceptions/app_exceptions.dart';

part 'video_player_state.freezed.dart';

@freezed
class VideoPlayerState with _$VideoPlayerState {
  const factory VideoPlayerState.loading() = _Loading;

  const factory VideoPlayerState.isPlaying({
    required bool isFullScreen,
    required Duration? startAt,
    required double volume,
  }) = _IsPlaying;

  const factory VideoPlayerState.isPaused({
    required bool isFullScreen,
    required Duration? startAt,
    required double volume,
  }) = _IsPaused;

  const factory VideoPlayerState.error(AppException error) = _Error;
}
