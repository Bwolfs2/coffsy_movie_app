import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../coffsy_design_system.dart';

class CardTrailer extends StatefulWidget {
  final String title, youtube;
  final VoidCallback onExitFullScreen;
  final int length;

  const CardTrailer({
    Key? key,
    required this.title,
    required this.youtube,
    required this.onExitFullScreen,
    required this.length,
  }) : super(key: key);

  @override
  State<CardTrailer> createState() => _CardTrailerState();
}

// ignore: prefer_mixin
class _CardTrailerState extends State<CardTrailer> with WidgetsBindingObserver {
  late final _controller = YoutubePlayerController(
    initialVideoId: widget.youtube,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
    ),
  );

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    widget.onExitFullScreen();
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: width / 1.2,
      child: Column(
        children: [
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: ColorPalettes.darkAccent,
                topActions: <Widget>[
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _controller.metadata.title,
                      style: TextStyle(
                        color: ColorPalettes.white,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
                // This for hide the full screen button
                bottomActions: [
                  const SizedBox(width: 14),
                  CurrentPosition(),
                  const SizedBox(width: 8),
                  ProgressBar(isExpanded: true),
                  RemainingDuration(),
                  const PlaybackSpeedButton(),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.length > 1,
            child: const SizedBox(
              height: 10,
            ),
          ),
          Visibility(
            visible: widget.length > 1,
            child: Container(
              height: 30,
              width: width,
              color: ColorPalettes.lightAccent,
              child: Center(
                child: Text(
                  'You must swipe here!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPalettes.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
