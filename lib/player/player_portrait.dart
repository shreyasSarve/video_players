part of player_widget;

/// This player type is default type
class PortraitPlayer extends StatefulWidget {
  final Player player;
  final PlayerConfiguration configuration;
  const PortraitPlayer({
    super.key,
    required this.player,
    required this.configuration,
  });

  @override
  State<PortraitPlayer> createState() => _PortraitPlayerState();
}

class _PortraitPlayerState extends State<PortraitPlayer> {
  late final Player _player;

  @override
  void initState() {
    super.initState();
    _player = widget.player;
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
                    child: Controls(
                      player: _player,
                      configuration: widget.configuration,
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
