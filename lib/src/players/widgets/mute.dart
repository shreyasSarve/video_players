// ignore_for_file: unused_element

part of players_controls.dart;

class _MuteButton extends StatelessWidget {
  const _MuteButton({super.key}) : _mode = 0;
  const _MuteButton.small({super.key}) : _mode = 1;
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
          return _PlayerIcon(
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
