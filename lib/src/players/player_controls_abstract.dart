// ignore_for_file: constant_identifier_names
part of players_controls.dart;

abstract class PlayerControls {
  Widget portrait(BuildContext context);
  Widget landscape(BuildContext context);
  void init(BuildContext context);
}

enum PlayerControlType { Netflix, Hotstar }

extension PlayerControlTypeExtention on PlayerControlType {
  PlayerControls getControls() {
    switch (this) {
      case PlayerControlType.Netflix:
        return _NetflixPlayer.playerControls;
      case PlayerControlType.Hotstar:
        return _NetflixPlayer.playerControls;
    }
  }
}
