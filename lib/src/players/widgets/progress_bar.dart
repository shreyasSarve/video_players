// ignore_for_file: unused_element

part of players_controls.dart;

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final player = PlayerProvider.of(context)!.player;
    final colorOptions = PlayerProvider.of(context)!.configuration.colorOptions;
    return ValueListenableBuilder<double>(
      valueListenable: player.completed,
      builder: (context, value, _) {
        return SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: DefaultValue.Thumb_Radius,
            ),
            overlayColor: colorOptions.progressbarColor
                .withAlpha(DefaultValue.Alpha_Value),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: DefaultValue.Overlay_Radius,
            ),
          ),
          child: Slider(
            value: value,
            onChanged: (value) {
              player.add(SeekTo(seekTo: value));
            },
            thumbColor: colorOptions.progressbarColor,
            activeColor: colorOptions.progressbarColor,
            inactiveColor: colorOptions.inactiveProgressbarColor,
          ),
        );
      },
    );
  }
}
