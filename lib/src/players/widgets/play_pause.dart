// ignore_for_file: unused_element

part of players_controls.dart;

class _PlayPause extends StatelessWidget {
  const _PlayPause({super.key});

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
            return _PlayerIcon(
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
