import 'package:flutter/material.dart';
import 'package:player/helper/utils.dart';
import 'package:player/player/config/configuration.dart';
import 'package:player/player_bloc/player_stream.dart';
import 'package:player/widgets/inherited.dart';

class Time extends StatelessWidget {
  const Time({
    super.key,
  }) : _mode = 0;

  const Time.startOnly({
    super.key,
  }) : _mode = 1;

  const Time.endOnly({
    super.key,
  }) : _mode = 2;

  final int _mode;
  @override
  Widget build(BuildContext context) {
    final player = PlayerProvider.of(context)!.player;
    final colorOptions = PlayerProvider.of(context)!.configuration.colorOptions;
    switch (_mode) {
      case 0:
        return _default(player, colorOptions);
      case 1:
        return _start(player, colorOptions);
      case 2:
        return _end(player, colorOptions);
      default:
        return _default(player, colorOptions);
    }
  }

  Widget _default(Player player, ColorOptions colorOptions) {
    return Row(
      children: [
        _start(player, colorOptions),
        const Spacer(),
        _end(player, colorOptions)
      ],
    );
  }

  Widget _end(Player player, ColorOptions colorOptions) {
    return ValueListenableBuilder(
      valueListenable: player.duration,
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
    );
  }

  Widget _start(Player player, ColorOptions colorOptions) {
    return ValueListenableBuilder(
      valueListenable: player.position,
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
    );
  }
}
