import 'package:chewie/chewie.dart';
import 'package:pssn/features/video_player/business_objects/video_player_source_bo.dart';

class VideoPlayerControllerRegistry {
  final Map<VideoPlayerSourceBO, ChewieController> _fullScreenRegistry =
      <VideoPlayerSourceBO, ChewieController>{};

  ChewieController? get({required VideoPlayerSourceBO videoPlayerSourceBO}) {
    return _fullScreenRegistry[videoPlayerSourceBO];
  }

  void add({
    required ChewieController chewieController,
    required VideoPlayerSourceBO videoPlayerSourceBO,
  }) {
    _fullScreenRegistry[videoPlayerSourceBO] = chewieController;
  }

  void remove({required VideoPlayerSourceBO videoPlayerSourceBO}) {
    _fullScreenRegistry.remove(videoPlayerSourceBO);
  }
}
