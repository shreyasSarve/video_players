// ignore_for_file: unused_element

part of players_controls.dart;

class _BottomProgressBar extends StatelessWidget {
  const _BottomProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final player = PlayerProvider.of(context)!.player;
    final colorOptions = PlayerProvider.configurationOf(context).colorOptions;
    return ValueListenableBuilder(
      valueListenable: player.completed,
      builder: (context, value, child) {
        return LinearProgressIndicator(
          value: value,
          valueColor:
              AlwaysStoppedAnimation<Color>(colorOptions.progressbarColor),
          backgroundColor: colorOptions.inactiveProgressbarColor,
          minHeight: 3,
        );
      },
    );
  }
}
