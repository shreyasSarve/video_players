// ignore_for_file: prefer_final_fields

part of player;

class _PlayerState {
  final VideoPlayerController _controller;
  final _showController = StreamCreator(value: true);
  final _isPlaying = StreamCreator(value: false);
  final _aspectRatio = StreamCreator(value: 16 / 9);
  final _position = StreamCreator(value: Duration.zero);
  final _duration = StreamCreator(value: Duration.zero);
  final _completed = StreamCreator(value: 0.0);
  final _fullscreen = StreamCreator(value: false);
  final _volume = StreamCreator(value: 0.0);
  final _isError = StreamCreator(value: false);
  bool _showingController = true;
  bool _isInitialised = false;

  _PlayerState({required Uri url})
      : _controller = VideoPlayerController.networkUrl(url);

  void dispose() {
    _controller.dispose();
    _showController.dispose();
    _isPlaying.dispose();
    _aspectRatio.dispose();
    _position.dispose();
    _duration.dispose();
    _completed.dispose();
    _showController.dispose();
    _fullscreen.dispose();
    _volume.dispose();
    _isError.dispose();
  }

  VideoPlayerController get controller => _controller;
}
