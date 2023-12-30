part of player_widget;

/// This player used when user clicks on fullscreen mode
/// uses Portait player only but in horizontal mode
class LandscapePlayer extends StatefulWidget {
  final Player player;
  final PlayerConfiguration configuration;
  const LandscapePlayer({
    super.key,
    required this.player,
    required this.configuration,
  });

  @override
  State<LandscapePlayer> createState() => _LandscapePlayerState();
}

class _LandscapePlayerState extends State<LandscapePlayer> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: PortraitPlayer(
          player: widget.player,
          configuration: widget.configuration,
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();
    widget.player.fullscreen.removeListener(() {});
    super.dispose();
  }
}
