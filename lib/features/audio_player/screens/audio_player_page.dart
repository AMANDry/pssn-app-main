import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pssn/features/audio_player/business_objects/video_player_source_bo.dart';
import 'package:pssn/features/audio_player/cubit/audio_player_cubit.dart';
import 'package:pssn/features/audio_player/cubit/audio_player_state.dart';
import 'package:pssn/features/audio_player/screens/audio_player_widget.dart';

class AudioPlayerPage extends StatelessWidget {
  const AudioPlayerPage();

  static const path = 'audio-player';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Center(
          child: AudioPlayerWidget(
            videoPlayerSourceBO: VideoPlayerSourceBO.network(
              "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
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
        const AudioPlayerContentWidget(),
        Container(
          height: 20.h,
        ),
        BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
          builder: (context, AudioPlayerState state) {
            return state.maybeMap(
              isPlaying: (_) {
                return IconButton(
                  onPressed: () {
                    context.read<AudioPlayerCubit>().pause();
                  },
                  icon: const Icon(Icons.pause),
                );
              },
              orElse: () {
                return IconButton(
                  onPressed: () {
                    context.read<AudioPlayerCubit>().play();
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
