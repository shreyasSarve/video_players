part of player_config;

class ColorOptions {
  final Color iconColor;
  final Color progressbarColor;
  final Color tintColor;
  final Color textColor;
  final Color inactiveProgressbarColor;
  const ColorOptions({
    this.iconColor = DefaultValue.Icon_Color,
    this.progressbarColor = DefaultValue.Progressbar_Color,
    this.tintColor = DefaultValue.Tint_Color,
    this.textColor = DefaultValue.Text_Color,
    this.inactiveProgressbarColor = DefaultValue.Inactive_Progressbar_Color,
  });
}
