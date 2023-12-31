part of player_widget;

/// This player used when user clicks on fullscreen mode
/// uses Portait player only but in horizontal mode
class LandscapePlayer extends StatefulWidget {
  const LandscapePlayer({super.key});

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: ValueListenableBuilder(
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
                        child: provider.controls.landscape(context),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();
    super.dispose();
  }
}
