import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:player/player/config/configuration.dart';
import 'package:player/player/widgets/player_icon.dart';
import 'package:player/player_bloc/player_stream.dart';
import 'package:player/widgets/inherited.dart';

class MuteButton extends StatelessWidget {
  const MuteButton({super.key}) : _mode = 0;
  const MuteButton.small({super.key}) : _mode = 1;
  final int _mode;
  @override
  Widget build(BuildContext context) {
    final player = PlayerProvider.playerOf(context);
    final configurations = PlayerProvider.configurationOf(context);
    return GestureDetector(
      onTap: () {
        player.add(ToggleSound());
      },
      child: ValueListenableBuilder(
        valueListenable: player.volume,
        builder: (context, value, child) {
          return PlayerIcon(
            iconConfiguration:
                DefaultPlayerIconConfiguration(isSmall: _mode == 1),
            iconData: value != 0 ? LucideIcons.volume2 : LucideIcons.volumeX,
            colorOptions: configurations.colorOptions,
          );
        },
      ),
    );
  }
}
