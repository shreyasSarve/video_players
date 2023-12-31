import 'package:flutter/material.dart';
import 'package:player/src/player/config/configuration.dart';
import 'package:player/src/player_bloc/player_stream.dart';
import 'package:player/src/players/player_controls.dart';

class PlayerProvider extends InheritedWidget {
  final Player player;
  final PlayerConfiguration configuration;
  final PlayerControls controls;
  const PlayerProvider({
    super.key,
    required this.controls,
    required this.player,
    required this.configuration,
    required Widget child,
  }) : super(child: child);

  static PlayerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PlayerProvider>();
  }

  static Player playerOf(BuildContext context) {
    return of(context)!.player;
  }

  static PlayerConfiguration configurationOf(BuildContext context) {
    return of(context)!.configuration;
  }

  @override
  bool updateShouldNotify(covariant PlayerProvider oldWidget) {
    return false;
  }
}
