import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pssn/features/audio_player/business_objects/video_player_source_bo.dart';
import 'package:pssn/features/audio_player/cubit/audio_player_cubit.dart';
import 'package:pssn/features/audio_player/cubit/audio_player_state.dart';
import 'package:pssn/features/audio_player/datasources/local/default_audio_player_local_data_source.dart';
import 'package:pssn/features/audio_player/service/audio_player_service.dart';
import 'package:video_player/video_player.dart';

class AudioPlayerWidget extends StatelessWidget {
  final VideoPlayerSourceBO videoPlayerSourceBO;
  final Widget child;

  const AudioPlayerWidget({
    required this.videoPlayerSourceBO,
    this.child = const AudioPlayerContentWidget(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AudioPlayerProviderWidget(
      videoPlayerSourceBO: videoPlayerSourceBO,
      child: AudioPlayerProviderCubitWidget(
        child: AudioPlayerBodyWidget(
          child: child,
        ),
      ),
    );
  }
}

class AudioPlayerProviderWidget extends StatelessWidget {
  final Widget child;
  final VideoPlayerSourceBO videoPlayerSourceBO;

  const AudioPlayerProviderWidget({
    required this.child,
    required this.videoPlayerSourceBO,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Provider.debugCheckInvalidValueType = null;
    return Provider<ChewieAudioController>(
      create: (_) {
        final videoPlayerController = videoPlayerSourceBO.when(
          network: (dataSource) => VideoPlayerController.network(dataSource),
          file: (file) => VideoPlayerController.file(file),
          asset: (dataSource) => VideoPlayerController.asset(dataSource),
          contentUri: (contentUri) =>
              VideoPlayerController.contentUri(contentUri),
        );

        final chewieAudioController = ChewieAudioController(
          videoPlayerController: videoPlayerController,
          customControls: const MaterialControls(),
          allowPlaybackSpeedChanging: false,
        );
        return chewieAudioController;
      },
      child: child,
      dispose: (_, chewieAudioController) {
        final videoPlayerController =
            chewieAudioController.videoPlayerController;
        chewieAudioController.dispose();
        videoPlayerController.dispose();
      },
    );
  }
}

class AudioPlayerProviderCubitWidget extends StatelessWidget {
  final Widget child;

  const AudioPlayerProviderCubitWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        final audioPlayerLocalDataSource = DefaultAudioPlayerLocalDataSource(
          chewieAudioController: context.read<ChewieAudioController>(),
        );

        final audioPlayerService = DefaultAudioPlayerService(
          audioPlayerLocalDataSource: audioPlayerLocalDataSource,
        );

        final audioPlayerCubit = AudioPlayerCubit(
          audioPlayerService: audioPlayerService,
        );

        return audioPlayerCubit;
      },
      child: child,
    );
  }
}

class AudioPlayerBodyWidget extends StatelessWidget {
  final Widget child;

  const AudioPlayerBodyWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (_, AudioPlayerState state) {
        return state.map(
          loading: (_) => const CircularProgressIndicator(),
          isPlaying: (state) {
            return child;
          },
          isPaused: (state) {
            return child;
          },
          error: (exception) => Text(exception.error.message),
        );
      },
    );
  }
}

class AudioPlayerContentWidget extends StatelessWidget {
  const AudioPlayerContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final chewieAudioController = context.read<ChewieAudioController>();
    return ChewieAudio(
      controller: chewieAudioController,
    );
  }
}
