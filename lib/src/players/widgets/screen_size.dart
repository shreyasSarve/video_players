// ignore_for_file: unused_element

part of players_controls.dart;

class _ScreenSize extends StatelessWidget {
  const _ScreenSize({super.key});

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
            return _PlayerIcon(
              iconConfiguration: configuration.iconConfig,
              iconData: LucideIcons.maximize,
              colorOptions: configuration.colorOptions,
            );
          }
          return _PlayerIcon(
            iconConfiguration: configuration.iconConfig,
            iconData: LucideIcons.shrink,
            colorOptions: configuration.colorOptions,
          );
        },
      ),
    );
  }
}
