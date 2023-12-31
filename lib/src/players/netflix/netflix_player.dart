part of players_controls.dart;

class _NetflixPlayer extends VideoPlayerWidget {
  _NetflixPlayer({
    required super.uri,
  }) : super(controls: _NetflixControls());

  static PlayerControls playerControls = _NetflixControls();
}
