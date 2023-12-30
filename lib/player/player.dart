library player_widget;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:player/helper/defaults.dart';
import 'package:player/helper/utils.dart';
import 'package:player/player/config/configuration.dart';
import 'package:player/player/config/options.dart';
import 'package:player/player_bloc/player_stream.dart';
import 'package:video_player/video_player.dart';

part './player_controls.dart';
part './player_icon.dart';
part './player_landscape.dart';
part './player_portrait.dart';

///* - uri : Uri of url which you want to stream/watch
class PlayerWidget extends StatefulWidget {
  PlayerWidget({
    super.key,
    required this.uri,
    PlayerConfiguration? configuration,
  }) {
    if (configuration != null) {
      this.configuration = configuration;
    } else {
      configuration = PlayerConfiguration.defaultConfig();
    }
  }
  final Uri uri;
  late final PlayerConfiguration configuration;
  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  late final Player _player;
  @override
  void initState() {
    super.initState();
    _player = Player(url: widget.uri);
    _player.add(InitialisePlayer());
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _player.fullscreen,
      builder: (context, value, child) {
        if (value) {
          return LandscapePlayer(
            player: _player,
            configuration: widget.configuration,
          );
        }
        SystemChrome.restoreSystemUIOverlays();
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        return PortraitPlayer(
          player: _player,
          configuration: widget.configuration,
        );
      },
    );
  }
}
