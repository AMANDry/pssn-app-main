import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_player_controller_data_bo.freezed.dart';

@freezed
class AudioPlayerControllerDataBO with _$AudioPlayerControllerDataBO {
  const factory AudioPlayerControllerDataBO({
    required bool isPlaying,
    required Duration? startAt,
    required double volume,
  }) = _AudioPlayerControllerDataBO;
}
