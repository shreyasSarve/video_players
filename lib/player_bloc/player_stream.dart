library player;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

part 'player_event.dart';
part 'player_state.dart';
part 'stream_creator.dart';

class Player extends _PlayerState {
  static const _delay = Duration(
    seconds: 5,
  );
  Player({required super.url});

  void add(PlayerEvent event) {
    final Type type = event.runtimeType;
    switch (type) {
      case Pause:
        _pause();
        break;
      case Play:
        _play();
        break;
      case SkipForward:
        _skipForward();
        break;
      case SkipBackward:
        _skipBackward();
        break;
      case TogglePlay:
        _togglePlayer();
        break;
      case InitialisePlayer:
        _init();
        break;
      case ShowControls:
        _showControls();
        break;
      case HideControls:
        _hideControls();
        break;
      case ToggleControls:
        _toggleControls();
        break;
      case ToggleFullscreen:
        _toggleFullscreen();
        break;
      case SeekTo:
        _seekTo((event as SeekTo).seekTo);
        break;
      case PlaybackSpeedTo:
        _playbackSpeedTo((event as PlaybackSpeedTo).speed);
      case Mute:
        _mute();
        break;
      case UnMute:
        _unmute();
        break;
      case ToggleSound:
        _toggleSound();
        break;
      default:
    }
  }

  _mute() {
    _volume.add(0);
    _controller.setVolume(0);
  }

  _unmute() {
    _volume.add(_volume.previous, savePrevious: false);
    _controller.setVolume(_volume.value);
  }

  _toggleSound() {
    if (_volume.value == 0) {
      _unmute();
    } else {
      _mute();
    }
  }

  Future<void> _init() async {
    _controller.initialize().whenComplete(() {
      final value = _controller.value;
      _aspectRatio.add(value.aspectRatio);
      _isPlaying.add(value.isPlaying);
      _duration.add(value.duration);
      _showController.add(true);
      _isInitialised = true;
      _volume.add(_controller.value.volume);
      _addListener();
    }).catchError((_) {
      _isError.add(true);
    });
  }

  void _addListener() {
    _controller.addListener(() {
      final value = _controller.value;
      _position.add(_controller.value.position);
      _duration.add(_controller.value.duration);
      _completed.add(value.position.inSeconds / value.duration.inSeconds);
      if (_controller.value.isCompleted) {
        _isPlaying.add(false);
      }
      if (_controller.value.hasError) _isError.add(true);
    });
  }

  void _playbackSpeedTo(double speed) {
    _controller.setPlaybackSpeed(speed);
  }

  void _exitFullscreen() {
    _fullscreen.add(false);
  }

  void _toFullscreen() {
    _fullscreen.add(true);
  }

  void _toggleFullscreen() {
    if (_fullscreen.value) {
      _exitFullscreen();
    } else {
      _toFullscreen();
    }
  }

  void _pause() {
    final controller = _controller;
    if (controller.value.isPlaying) {
      controller.pause();
      _isPlaying.add(false);
    }
  }

  void _togglePlayer() {
    if (_controller.value.isPlaying) {
      _pause();
    } else {
      _play();
    }
  }

  void _play() {
    final controller = _controller;
    if (controller.value.isInitialized && !controller.value.isPlaying) {
      controller.play();
      _isPlaying.add(true);
    }
  }

  void _skipForward() {
    final position = _controller.value.position;
    final duration = _controller.value.duration;
    _controller.seekTo(
        Duration(seconds: min(position.inSeconds + 10, duration.inSeconds)));
  }

  void _skipBackward() {
    final position = _controller.value.position;
    _controller.seekTo(Duration(seconds: max(0, position.inSeconds - 10)));
  }

  void _seekTo(double ratio) {
    final position = Duration(
        seconds: (controller.value.duration.inSeconds * ratio).toInt());
    _controller.seekTo(position);
  }

  void _showControls() {
    _showingController = true;
    _showController.add(_showingController);
    Future.delayed(_delay, () {
      _hideControls();
    });
  }

  void _hideControls() {
    _showingController = false;
    _showController.add(_showingController);
  }

  void _toggleControls() {
    if (_showingController) {
      _hideControls();
    } else {
      _showControls();
    }
  }

  ValueNotifier<Duration> get position => _position.stream;
  ValueNotifier<Duration> get duration => _duration.stream;
  ValueNotifier<double> get aspectratio => _aspectRatio.stream;
  ValueNotifier<double> get completed => _completed.stream;
  ValueNotifier<bool> get isPlaying => _isPlaying.stream;
  ValueNotifier<bool> get showControls => _showController.stream;
  ValueNotifier<bool> get fullscreen => _fullscreen.stream;
  ValueNotifier<double> get volume => _volume.stream;
  ValueNotifier<bool> get error => _isError.stream;
  bool get isInitialised => _isInitialised;
}
