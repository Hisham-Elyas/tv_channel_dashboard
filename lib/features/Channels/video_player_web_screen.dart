import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoPlayerWeb extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWeb({super.key, required this.videoUrl});

  @override
  _VideoPlayerWebState createState() => _VideoPlayerWebState();
}

class _VideoPlayerWebState extends State<VideoPlayerWeb> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        key: webViewKey,
        initialData: InAppWebViewInitialData(
          data: '''
          <!DOCTYPE html>
          <html>
          <head>
            <link href="https://vjs.zencdn.net/8.10.0/video-js.css" rel="stylesheet">
            <script src="https://vjs.zencdn.net/8.10.0/video.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@videojs/http-streaming@2.16.1/dist/videojs-http-streaming.min.js"></script>
          </head>
          <body style="margin:0;">
            <video-js 
              id="videoPlayer" 
              class="vjs-default-skin" 
              style="width:100vw;height:100vh" 
              controls 
              autoplay 
              muted>
              <source src="${widget.videoUrl}" type="application/x-mpegURL">
            </video-js>
            <script>
              var player = videojs('videoPlayer', {
                html5: {
                  hls: {
                    overrideNative: true
                  }
                }
              });
              player.ready(function() {
                this.play();
              });
            </script>
          </body>
          </html>
          ''',
          mimeType: 'text/html',
          encoding: 'utf-8',
        ),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onConsoleMessage: (controller, consoleMessage) {
          print("WebView Console: ${consoleMessage.message}");
        },
      ),
    );
  }
}