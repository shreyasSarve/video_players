library player_config;

import 'package:flutter/material.dart';
import 'package:player/src/helper/defaults.dart';
import 'package:player/src/player/config/options.dart';

part './colors_options.dart';
part './icon_configuration.dart';

class PlayerConfiguration {
  static const defaultColorOptions = ColorOptions();
  final Map<Options, bool> _isOptionRequired = {};
  final ColorOptions colorOptions;
  final double iconSize;
  PlayerConfiguration({
    List<Options> options = Options.values,
    this.colorOptions = defaultColorOptions,
    this.iconSize = 25.0,
  }) {
    _addRequiredOptions(options);
  }

  void _addRequiredOptions(List<Options> options) {
    for (var element in options) {
      _isOptionRequired[element] = true;
    }
  }

  bool isOptionOn(Options option) {
    return _isOptionRequired.containsKey(option);
  }

  factory PlayerConfiguration.defaultConfig() {
    return PlayerConfiguration();
  }

  PlayerIconCofiguration get iconConfig {
    return PlayerIconCofiguration.fromPlayerConfiguration(this);
  }
}
