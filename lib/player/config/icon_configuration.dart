part of player_config;

class PlayerIconCofiguration {
  final double size;
  final Color color;
  PlayerIconCofiguration({
    required this.size,
    required this.color,
  });
  factory PlayerIconCofiguration.fromPlayerConfiguration(
      PlayerConfiguration configuration) {
    return PlayerIconCofiguration(
      size: configuration.iconSize,
      color: configuration.colorOptions.iconColor,
    );
  }
}

class DefaultPlayerIconConfiguration extends PlayerIconCofiguration {
  static const defaultColor = Colors.white;
  static const defaultSize = 25.0;
  DefaultPlayerIconConfiguration()
      : super(color: defaultColor, size: defaultSize);
}
