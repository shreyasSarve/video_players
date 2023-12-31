// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:player/players/netflix/netflix_player.dart';

abstract class PlayerControls {
  Widget portrait(BuildContext context);
  Widget landscape(BuildContext context);
  void init(BuildContext context);
}

enum PlayerControlType { Netflix, Hotstar }

extension PlayerControlTypeExtention on PlayerControlType {
  PlayerControls getControls() {
    switch (this) {
      case PlayerControlType.Netflix:
        return NetflixPlayer.playerControls;
      case PlayerControlType.Hotstar:
        return NetflixPlayer.playerControls;
    }
  }
}
