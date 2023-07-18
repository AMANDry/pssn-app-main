import 'package:pssn/common/business_objects/result.dart';
import 'package:pssn/features/audio_player/business_objects/audio_player_controller_data_bo.dart';
import 'package:pssn/features/audio_player/datasources/local/audio_player_local_data_source.dart';

abstract class AudioPlayerService {
  Stream<Result<AudioPlayerControllerDataBO>> get dataStreamController;

  Future<void> init();

  Future<void> play();

  Future<void> pause();

  Future<void> togglePause();

  Future<void> seekTo(Duration duration);

  Future<void> setVolume(double volume);

  Future<void> dispose();
}

class DefaultAudioPlayerService implements AudioPlayerService {
  DefaultAudioPlayerService({
    required this.audioPlayerLocalDataSource,
  });

  final AudioPlayerLocalDataSource audioPlayerLocalDataSource;

  @override
  Stream<Result<AudioPlayerControllerDataBO>> get dataStreamController {
    return audioPlayerLocalDataSource.dataStreamController;
  }

  @override
  Future<void> dispose() {
    return audioPlayerLocalDataSource.dispose();
  }

  @override
  Future<void> init() {
    return audioPlayerLocalDataSource.init();
  }

  @override
  Future<void> pause() async {
    return audioPlayerLocalDataSource.pause();
  }

  @override
  Future<void> play() async {
    return audioPlayerLocalDataSource.play();
  }

  @override
  Future<void> seekTo(Duration duration) async {
    return audioPlayerLocalDataSource.seekTo(duration);
  }

  @override
  Future<void> setVolume(double volume) async {
    return audioPlayerLocalDataSource.setVolume(volume);
  }

  @override
  Future<void> togglePause() async {
    return audioPlayerLocalDataSource.togglePause();
  }
}
