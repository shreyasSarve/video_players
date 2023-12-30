part of player_widget;

///* This class creates control for video player
class Controls extends StatefulWidget {
  final Player player;
  final PlayerConfiguration configuration;
  const Controls({
    super.key,
    required this.player,
    required this.configuration,
  });
  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls>
    with SingleTickerProviderStateMixin {
  double completedValue = 0;
  final ValueNotifier<bool> isPlaying = ValueNotifier(false);
  late final PlayerConfiguration configuration;
  late final ColorOptions colorOptions;
  @override
  void initState() {
    super.initState();
    configuration = widget.configuration;
    colorOptions = configuration.colorOptions;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: widget.player.showControls,
            builder: (context, value, child) {
              return Container(
                color: value ? colorOptions.tintColor : Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: GestureDetector(
                        onTap: () {
                          widget.player.add(ToggleControls());
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.player.showControls,
          builder: (context, value, child) {
            if (value) return child!;
            return Container();
          },
          child: Container(
            color: colorOptions.tintColor,
            child: Container(
              padding: DefaultValue.Padding,
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  if (configuration.isOptionOn(Options.Time)) _timeWidget(),
                  const SizedBox(
                    height: 5,
                  ),
                  if (configuration.isOptionOn(Options.Progressbar))
                    _progressbar(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (configuration.isOptionOn(Options.MuteButton)) _mute(),
                      if (configuration.isOptionOn(Options.SkipBack))
                        PlayerIcon(
                          iconData: LucideIcons.skipBack,
                          cofiguration: DefaultPlayerIconConfiguration(),
                          onPressed: () {
                            widget.player.add(SkipBackward());
                          },
                        ),
                      if (configuration.isOptionOn(Options.Play_Pause))
                        _playpause(),
                      if (configuration.isOptionOn(Options.SkipForward))
                        PlayerIcon(
                          cofiguration: DefaultPlayerIconConfiguration(),
                          iconData: LucideIcons.skipForward,
                          onPressed: () {
                            widget.player.add(SkipForward());
                          },
                        ),
                      if (configuration.isOptionOn(Options.ScreenSize))
                        _screensize(context)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.player.showControls,
          builder: (context, value, child) {
            if (!value) return child!;
            return Container();
          },
          child: ValueListenableBuilder(
            valueListenable: widget.player.completed,
            builder: (context, value, child) {
              return LinearProgressIndicator(
                value: 0.5,
                color: const Color(0xffdb0000),
                backgroundColor: const Color(0xffdb0000).withOpacity(0.35),
                minHeight: 2,
              );
            },
          ),
        ),
      ],
    );
  }

  GestureDetector _screensize(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.player.add(ToggleFullscreen());
        if (widget.player.fullscreen.value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LandscapePlayer(
                player: widget.player,
                configuration: widget.configuration,
              ),
            ),
          );
        } else {
          Navigator.pop(context);
        }
      },
      child: ValueListenableBuilder(
        valueListenable: widget.player.fullscreen,
        builder: (context, value, child) {
          if (!value) {
            return PlayerIcon(
              cofiguration: configuration.iconConfig,
              iconData: LucideIcons.maximize,
            );
          }
          return PlayerIcon(
            cofiguration: configuration.iconConfig,
            iconData: LucideIcons.shrink,
          );
        },
      ),
    );
  }

  GestureDetector _playpause() {
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: DefaultValue.Animation_Duration,
        ),
        child: ValueListenableBuilder(
          valueListenable: widget.player.isPlaying,
          builder: (context, value, child) {
            return PlayerIcon(
              iconData: value ? LucideIcons.pause : LucideIcons.play,
              cofiguration: DefaultPlayerIconConfiguration(),
            );
          },
        ),
      ),
      onTap: () {
        widget.player.add(TogglePlay());
      },
    );
  }

  GestureDetector _mute() {
    return GestureDetector(
      onTap: () {
        widget.player.add(ToggleSound());
      },
      child: ValueListenableBuilder(
        valueListenable: widget.player.volume,
        builder: (context, value, child) {
          return PlayerIcon(
            cofiguration: DefaultPlayerIconConfiguration(),
            iconData: value != 0 ? LucideIcons.volume2 : LucideIcons.volumeX,
          );
        },
      ),
    );
  }

  ValueListenableBuilder<double> _progressbar() {
    return ValueListenableBuilder<double>(
      valueListenable: widget.player.completed,
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
            value: 0.3,
            onChanged: (value) {
              widget.player.add(SeekTo(seekTo: value));
            },
            thumbColor: colorOptions.progressbarColor,
            activeColor: colorOptions.progressbarColor,
            inactiveColor: const Color(0xffdb0000).withOpacity(0.35),
          ),
        );
      },
    );
  }

  Row _timeWidget() {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: widget.player.position,
          builder: (context, value, child) {
            final time = Utils.timeToString(value);
            return Text(
              time,
              style: TextStyle(
                color: colorOptions.textColor,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
        const Spacer(),
        ValueListenableBuilder(
          valueListenable: widget.player.duration,
          builder: (context, value, child) {
            final time = Utils.timeToString(value);
            return Text(
              time,
              style: TextStyle(
                color: colorOptions.textColor,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        )
      ],
    );
  }
}
