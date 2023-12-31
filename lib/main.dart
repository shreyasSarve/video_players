import 'package:flutter/material.dart';
import 'package:player/src/player/player.dart';
import 'package:player/src/players/player_controls.dart';

const String streamUrl2 =
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

void main() => runApp(const VideoApp());

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: VideoPlayerWidget(
            uri: Uri.parse(streamUrl2),
            controlType: PlayerControlType.Netflix,
          ),
        ),
      ),
    );
  }
}
