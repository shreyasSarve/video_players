import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:player/helper/defaults.dart';
import 'package:player/player/config/configuration.dart';
import 'package:player/player/widgets/player_icon.dart';
import 'package:player/player_bloc/player_stream.dart';
import 'package:player/widgets/inherited.dart';

class PlayPause extends StatelessWidget {
  const PlayPause({super.key});

  @override
  Widget build(BuildContext context) {
    final player = PlayerProvider.of(context)!.player;
    final configurations = PlayerProvider.of(context)!.configuration;
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: DefaultValue.Animation_Duration,
        ),
        child: ValueListenableBuilder(
          valueListenable: player.isPlaying,
          builder: (context, value, child) {
            return PlayerIcon(
              iconData: value ? LucideIcons.pause : LucideIcons.play,
              iconConfiguration: DefaultPlayerIconConfiguration(),
              colorOptions: configurations.colorOptions,
            );
          },
        ),
      ),
      onTap: () {
        player.add(TogglePlay());
      },
    );
  }
}
