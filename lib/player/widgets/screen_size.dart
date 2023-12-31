import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:player/player/player.dart';
import 'package:player/player/widgets/player_icon.dart';
import 'package:player/player_bloc/player_stream.dart';
import 'package:player/widgets/inherited.dart';

class ScreenSize extends StatelessWidget {
  const ScreenSize({super.key});

  @override
  Widget build(BuildContext context) {
    final player = PlayerProvider.playerOf(context);
    final configuration = PlayerProvider.configurationOf(context);

    return GestureDetector(
      onTap: () {
        player.add(ToggleFullscreen());
        if (player.fullscreen.value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LandscapePlayer(),
            ),
          );
        } else {
          Navigator.pop(context);
        }
      },
      child: ValueListenableBuilder(
        valueListenable: player.fullscreen,
        builder: (context, value, child) {
          if (!value) {
            return PlayerIcon(
              iconConfiguration: configuration.iconConfig,
              iconData: LucideIcons.maximize,
              colorOptions: configuration.colorOptions,
            );
          }
          return PlayerIcon(
            iconConfiguration: configuration.iconConfig,
            iconData: LucideIcons.shrink,
            colorOptions: configuration.colorOptions,
          );
        },
      ),
    );
  }
}
