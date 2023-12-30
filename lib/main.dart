import 'package:flutter/material.dart';
import 'package:player/player/config/configuration.dart';
import 'package:player/player/player.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const MaterialApp(home: VideoApp()));

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

const String streamUrl =
    "http://192.168.0.105:8096/Items/2249f6243de8f64a5c3f55643e7e67f5/Download?api_key=b0b1b4d895b94443bd59b3d65e1c7a0b";
const String streamUrl2 =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
  }

  bool showControls = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          // child: SliderButton(
          //   onSlided: () {},
          // ),
          child: PlayerWidget(
            uri: Uri.parse(streamUrl2),
            configuration: PlayerConfiguration(
              options: [],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
