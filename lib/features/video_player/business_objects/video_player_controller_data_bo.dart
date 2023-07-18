import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_player_controller_data_bo.freezed.dart';

@freezed
class VideoPlayerControllerDataBO with _$VideoPlayerControllerDataBO {
  const factory VideoPlayerControllerDataBO({
    required bool isPlaying,
    required bool isFullScreen,
    required Duration? startAt,
    required double aspectRatio,
    required double volume,
  }) = _VideoPlayerControllerDataBO;
}
