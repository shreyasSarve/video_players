part of players_controls.dart;

class _NetflixControls extends PlayerControls {
  late PlayerConfiguration configuration;
  late ColorOptions colorOptions;
  late Player player;

  @override
  Widget portrait(BuildContext context) {
    return build(context);
  }

  @override
  Widget landscape(BuildContext context) {
    return build(context);
  }

  @override
  void init(BuildContext context) {
    final provider = PlayerProvider.of(context)!;
    player = provider.player;
    configuration = provider.configuration;
    colorOptions = configuration.colorOptions;
  }

  Widget build(BuildContext context) {
    init(context);
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: DefaultValue.Animation_Duration,
      ),
      curve: Curves.easeInSine,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: player.showControls,
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () {
                    player.add(ToggleControls());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: value ? colorOptions.tintColor : Colors.transparent,
                    child: value ? const _PlayPause() : null,
                  ),
                );
              },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: player.showControls,
            builder: (context, value, child) {
              if (value) return child!;
              return Container();
            },
            child: Container(
              color: colorOptions.tintColor,
              child: Container(
                padding: DefaultValue.Padding,
                margin: const EdgeInsets.only(bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: const _MuteButton.small(),
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: _ProgressBar(),
                        ),
                        _Time.startOnly(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: player.showControls,
            builder: (context, value, child) {
              if (!value) return child!;
              return Container();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: const _MuteButton.small(),
                ),
                const _BottomProgressBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
