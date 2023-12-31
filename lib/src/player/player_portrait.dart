part of player_widget;

/// This player type is default type
class PortraitPlayer extends StatefulWidget {
  const PortraitPlayer({super.key});

  @override
  State<PortraitPlayer> createState() => _PortraitPlayerState();
}

class _PortraitPlayerState extends State<PortraitPlayer> {
  late final Player _player;
  late final PlayerProvider provider;

  void init() {
    provider = PlayerProvider.of(context)!;
    _player = PlayerProvider.playerOf(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _player.aspectratio,
      builder: (context, aspectRatio, _) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return AspectRatio(
              aspectRatio: aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    child: VideoPlayer(
                      _player.controller,
                    ),
                    onTap: () {
                      _player.add(ToggleControls());
                    },
                  ),
                  Positioned.fill(
                    bottom: 0,
                    child: ValueListenableBuilder(
                      valueListenable: _player.error,
                      builder: (context, value, child) {
                        if (!value) return child!;
                        return PlayerProvider.of(context)!.errorWidget;
                      },
                      child: provider.controls.portrait(context),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
