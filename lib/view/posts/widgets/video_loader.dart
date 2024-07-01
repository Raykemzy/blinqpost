import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoLoader extends StatefulWidget {
  final String postId;
  final String videoUrl;
  const VideoLoader({
    super.key,
    required this.postId,
    required this.videoUrl,
  });

  @override
  State<VideoLoader> createState() => _VideoLoaderState();
}

class _VideoLoaderState extends State<VideoLoader>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  ValueNotifier<bool> postIsVisible = ValueNotifier<bool>(false);
  ValueNotifier<double> volume = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0)
      ..setLooping(true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      VisibilityDetectorController.instance.notifyNow();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder(
      valueListenable: postIsVisible,
      builder: (context, isVisible, _) {
        if (isVisible) {
          _controller.play();
        } else {
          _controller.pause();
        }
        return VisibilityDetector(
          key: ValueKey(widget.postId),
          onVisibilityChanged: (info) {
            if (info.visibleFraction >= 0.8) {
              postIsVisible.value = true;
            } else {
              postIsVisible.value = false;
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ValueListenableBuilder(
                    valueListenable: volume,
                    builder: (context, value, _) {
                      return GestureDetector(
                        onTap: _muteVideo,
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            value == 0
                                ? Icons.volume_mute_rounded
                                : Icons.volume_up_rounded,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _muteVideo() {
    if (volume.value == 0) {
      _controller.setVolume(1);
      volume.value = 1;
      return;
    }
    if (volume.value == 1) {
      _controller.setVolume(0);
      volume.value = 0;
      return;
    }
  }
}
