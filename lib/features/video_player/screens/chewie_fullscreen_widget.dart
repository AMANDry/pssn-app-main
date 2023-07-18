import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

class ChewieFullscreenWidget extends StatefulWidget {
  final ChewieControllerProvider controllerProvider;

  const ChewieFullscreenWidget({
    super.key,
    required this.controllerProvider,
  });

  @override
  State<ChewieFullscreenWidget> createState() => _ChewieFullscreenWidgetState();
}

class _ChewieFullscreenWidgetState extends State<ChewieFullscreenWidget> {
  bool popped = false;

  @override
  void initState() {
    super.initState();

    widget.controllerProvider.controller.addListener(_listenAsDisposable);
  }

  void _listenAsDisposable() {
    if (!widget.controllerProvider.controller.isFullScreen && !popped) {
      _exit();
    }
  }

  void _exit() {
    popped = true;
    Navigator.of(
      context,
      rootNavigator: widget.controllerProvider.controller.useRootNavigator,
    ).pop();
  }

  @override
  void dispose() {
    widget.controllerProvider.controller.removeListener(_listenAsDisposable);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          _exit();
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: widget.controllerProvider,
          ),
        ),
      );
}
