library netflix_player;

import 'package:flutter/material.dart';
import 'package:player/helper/defaults.dart';
import 'package:player/player/config/configuration.dart';
import 'package:player/player/player.dart';
import 'package:player/player/widgets/bottom_progress_bar.dart';
import 'package:player/player/widgets/mute.dart';
import 'package:player/player/widgets/play_pause.dart';
import 'package:player/player/widgets/progress_bar.dart';
import 'package:player/player/widgets/time.dart';
import 'package:player/player_bloc/player_stream.dart';
import 'package:player/players/player_controls.dart';
import 'package:player/widgets/inherited.dart';

part './netflix_controls.dart';

class NetflixPlayer extends VideoPlayerWidget {
  NetflixPlayer({
    super.key,
    required super.uri,
  }) : super(controls: _NetflixControls());

  static PlayerControls playerControls = _NetflixControls();
}
