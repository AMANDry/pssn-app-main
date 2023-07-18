import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pssn/features/video_player/business_objects/video_player_source_bo.dart';
import 'package:pssn/features/video_player/cubit/video_player_cubit.dart';
import 'package:pssn/features/video_player/cubit/video_player_state.dart';
import 'package:pssn/features/video_player/screens/video_player_widget.dart';

class VideoPlayerPage extends StatelessWidget {
  const VideoPlayerPage();

  static const path = 'video-player';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Center(
          child: VideoPlayerWidget(
            videoPlayerSourceBO: VideoPlayerSourceBO.network(
              "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
            ),
            child: ExampleOutButtonPlayPauseWidget(),
          ),
        ),
      ),
    );
  }
}

class ExampleOutButtonPlayPauseWidget extends StatelessWidget {
  const ExampleOutButtonPlayPauseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const VideoPlayerContentWidget(),
        Container(
          height: 20.h,
        ),
        BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, VideoPlayerState state) {
            return state.maybeMap(
              isPlaying: (_) {
                return IconButton(
                  onPressed: () {
                    context.read<VideoPlayerCubit>().pause();
                  },
                  icon: const Icon(Icons.pause),
                );
              },
              orElse: () {
                return IconButton(
                  onPressed: () {
                    context.read<VideoPlayerCubit>().play();
                  },
                  icon: const Icon(Icons.play_arrow),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
