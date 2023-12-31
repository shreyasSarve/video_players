library player_widget;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:player/src/player/config/configuration.dart';
import 'package:player/src/player_bloc/player_stream.dart';
import 'package:player/src/players/player_controls.dart';
import 'package:player/src/widgets/inherited.dart';
import 'package:video_player/video_player.dart';

part './player_landscape.dart';
part './player_portrait.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({
    super.key,
    required this.uri,
    PlayerControlType? controlType,
    PlayerControls? controls,
    PlayerConfiguration? configuration,
  }) {
    if (configuration != null) {
      this.configuration = configuration;
    } else {
      this.configuration = PlayerConfiguration.defaultConfig();
    }
    final controlTypeSet = controlType != null;
    final controlsSet = controls != null;
    assert(
      controlTypeSet || controlsSet,
      "Both controlType & controls cannot be null set one of them",
    );
    assert(
      !controlTypeSet || !controlsSet,
      "Both controlType & controls cannot be set set only one of them",
    );

    if (controls != null) {
      this.controls = controls;
    } else {
      this.controls = controlType!.getControls();
    }
  }

  final Uri uri;
  late final PlayerConfiguration configuration;
  late final PlayerControls controls;
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final Player _player;
  @override
  void initState() {
    super.initState();
    _player = Player(url: widget.uri);
    _player.add(InitialisePlayer());
  }

  @override
  Widget build(BuildContext context) {
    return PlayerProvider(
      player: _player,
      configuration: widget.configuration,
      controls: widget.controls,
      child: ValueListenableBuilder(
        valueListenable: _player.fullscreen,
        builder: (context, value, child) {
          if (value) {
            return const LandscapePlayer();
          }
          SystemChrome.restoreSystemUIOverlays();
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          return const PortraitPlayer();
        },
      ),
    );
  }
}
