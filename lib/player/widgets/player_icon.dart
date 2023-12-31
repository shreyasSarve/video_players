import 'package:flutter/material.dart';
import 'package:player/player/config/configuration.dart';

class PlayerIcon extends StatelessWidget {
  const PlayerIcon({
    super.key,
    required this.colorOptions,
    required this.iconConfiguration,
    required this.iconData,
    this.onPressed,
  });
  final ColorOptions colorOptions;
  final PlayerIconCofiguration iconConfiguration;
  final IconData iconData;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: colorOptions.iconBgColor,
      radius: iconConfiguration.size,
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(
          iconData,
          color: iconConfiguration.color,
          size: iconConfiguration.size,
        ),
      ),
    );
  }
}
