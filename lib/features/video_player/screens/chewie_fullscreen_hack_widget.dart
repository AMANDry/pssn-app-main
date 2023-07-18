import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChewieFullscreenHackWidget extends StatefulWidget {
  final ChewieController controller;

  const ChewieFullscreenHackWidget({
    super.key,
    required this.controller,
  });

  @override
  State<ChewieFullscreenHackWidget> createState() =>
      ChewieFullscreenHackWidgetState();
}

class ChewieFullscreenHackWidgetState
    extends State<ChewieFullscreenHackWidget> {
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    isFullScreen = widget.controller.isFullScreen;
    widget.controller.addListener(_listenAsDisposable);
  }

  void _listenAsDisposable() {
    if (widget.controller.isFullScreen != isFullScreen) {
      if (mounted) {
        setState(() {
          isFullScreen = widget.controller.isFullScreen;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFullScreen) {
      return const SizedBox.shrink();
    } else {
      return Chewie(
        controller: widget.controller,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
