class Utils {
  static String timeToString(Duration duration) {
    final int minutes = (duration.inSeconds) ~/ 60;
    final seconds = (duration.inSeconds) % 60;
    final secondsString = seconds.toString().padLeft(2, '0');
    final minutesString = minutes.toString().padLeft(2, '0');
    return "$minutesString : $secondsString";
  }
}
