import 'package:flutter/material.dart';
import 'package:modern_player/modern_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModernPlayer.createPlayer(
            video: ModernPlayerVideo.multiple([
              ModernPlayerVideoData.network(
                label: "1080p",
                url: videoUrl,
              ),
              ModernPlayerVideoData.network(label: "720p", url: videoUrl),
              ModernPlayerVideoData.network(label: "480p", url: videoUrl),
            ]),
            callbackOptions: ModernPlayerCallbackOptions(
              onBackPressed: () async {},
              onMenuPressed: () {},
            ),
            controlsOptions: ModernPlayerControlsOptions(
              showBackbutton: true,
              // showBottomBar: true,
              doubleTapToSeek: false,
              showMenu: false,
            ),
            subtitles: [],
            audioTracks: [],
            themeOptions: ModernPlayerThemeOptions(),
            translationOptions:
                ModernPlayerTranslationOptions.menu(qualityHeaderText: ''),
            options: ModernPlayerOptions(
                allowScreenSleep: false,
                autoVisibilityPause: false,
                videoStartAt: 5000 // in milliseconds
                )));
  }
}
