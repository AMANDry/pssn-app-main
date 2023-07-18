import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pssn/common/di/injections.dart';
import 'package:pssn/features/video_player/business_objects/video_player_source_bo.dart';
import 'package:pssn/features/video_player/cubit/video_player_cubit.dart';
import 'package:pssn/features/video_player/cubit/video_player_state.dart';
import 'package:pssn/features/video_player/datasources/local/default_video_player_local_data_source.dart';
import 'package:pssn/features/video_player/screens/chewie_fullscreen_hack_widget.dart';
import 'package:pssn/features/video_player/screens/chewie_fullscreen_widget.dart';
import 'package:pssn/features/video_player/screens/video_player_controller_registry.dart';
import 'package:pssn/features/video_player/service/video_player_service.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerSourceBO videoPlayerSourceBO;
  final Widget child;

  const VideoPlayerWidget({
    required this.videoPlayerSourceBO,
    this.child = const VideoPlayerContentWidget(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VideoPlayerProviderWidget(
      videoPlayerSourceBO: videoPlayerSourceBO,
      child: VideoPlayerProviderCubitWidget(
        child: VideoPlayerBodyWidget(
          child: child,
        ),
      ),
    );
  }
}

class VideoPlayerProviderWidget extends StatelessWidget {
  final Widget child;
  final VideoPlayerSourceBO videoPlayerSourceBO;

  const VideoPlayerProviderWidget({
    required this.child,
    required this.videoPlayerSourceBO,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Provider.debugCheckInvalidValueType = null;
    return Provider<ChewieController>(
      create: (_) {
        final VideoPlayerControllerRegistry videoPlayerControllerRegistry =
            getIt();
        final chewieController = videoPlayerControllerRegistry.get(
          videoPlayerSourceBO: videoPlayerSourceBO,
        );
        if (chewieController == null) {
          final videoPlayerController = videoPlayerSourceBO.when(
            network: (dataSource) => VideoPlayerController.network(dataSource),
            file: (file) => VideoPlayerController.file(file),
            asset: (dataSource) => VideoPlayerController.asset(dataSource),
            contentUri: (contentUri) =>
                VideoPlayerController.contentUri(contentUri),
          );

          final chewieController = ChewieController(
            videoPlayerController: videoPlayerController,
            customControls: const MaterialControls(),
            allowPlaybackSpeedChanging: false,
            deviceOrientationsAfterFullScreen: [
              DeviceOrientation.portraitUp,
            ],
            routePageBuilder:
                (context, animation, secondaryAnimation, controllerProvider) =>
                    AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) =>
                  ChewieFullscreenWidget(
                controllerProvider: controllerProvider,
              ),
            ),
            showOptions: false,
            looping: true,
          );
          return chewieController;
        } else {
          return chewieController;
        }
      },
      dispose: (_, chewieController) {
        final VideoPlayerControllerRegistry videoPlayerControllerRegistry =
            getIt();
        if (!chewieController.isFullScreen) {
          final videoPlayerController = chewieController.videoPlayerController;
          videoPlayerControllerRegistry.remove(
            videoPlayerSourceBO: videoPlayerSourceBO,
          );
          chewieController.dispose();
          videoPlayerController.dispose();
        } else {
          videoPlayerControllerRegistry.add(
            chewieController: chewieController,
            videoPlayerSourceBO: videoPlayerSourceBO,
          );
        }
      },
      child: child,
    );
  }
}

class VideoPlayerProviderCubitWidget extends StatelessWidget {
  final Widget child;

  const VideoPlayerProviderCubitWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        final videoPlayerLocalDataSource = DefaultVideoPlayerLocalDataSource(
          chewieController: context.read<ChewieController>(),
        );

        final videoPlayerService = DefaultVideoPlayerService(
          videoPlayerLocalDataSource: videoPlayerLocalDataSource,
        );

        final videoPlayerCubit = VideoPlayerCubit(
          videoPlayerService: videoPlayerService,
        );

        return videoPlayerCubit;
      },
      child: child,
    );
  }
}

class VideoPlayerBodyWidget extends StatelessWidget {
  final Widget child;

  const VideoPlayerBodyWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
      builder: (_, VideoPlayerState state) {
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

class VideoPlayerContentWidget extends StatelessWidget {
  const VideoPlayerContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final chewieController = context.read<ChewieController>();
    return AspectRatio(
      aspectRatio: chewieController.videoPlayerController.value.aspectRatio,
      child: ChewieFullscreenHackWidget(
        controller: chewieController,
      ),
    );
  }
}
