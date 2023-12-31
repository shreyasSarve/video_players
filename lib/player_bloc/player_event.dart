part of player;

@immutable
sealed class PlayerEvent {}

class Pause extends PlayerEvent {}

class Play extends PlayerEvent {}

class SkipForward extends PlayerEvent {}

class SkipBackward extends PlayerEvent {}

class TogglePlay extends PlayerEvent {}

class InitialisePlayer extends PlayerEvent {}

class ShowControls extends PlayerEvent {
  final bool always;
  ShowControls({this.always = false});
}

class HideControls extends PlayerEvent {}

class ToggleControls extends PlayerEvent {}

class ToggleFullscreen extends PlayerEvent {}

class SeekTo extends PlayerEvent {
  final double seekTo;
  SeekTo({required this.seekTo});
}

class Mute extends PlayerEvent {}

class UnMute extends PlayerEvent {}

class ToggleSound extends PlayerEvent {}

class PlaybackSpeedTo extends PlayerEvent {
  final double speed;
  PlaybackSpeedTo({required this.speed});
}
