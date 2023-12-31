part of player;

/// This class is responsible for creating object
/// on there value change where we can listen to
/// instead of creating stream controller & steam sink we can take advantage of this class
/// - add method saves previous value if required
///   this method adds event to (value) to object & notifies hoever is listinig to value
///   helpful when used with ValueListenableBuilder
class StreamCreator<T> {
  final ValueNotifier<T> _controller;
  StreamCreator({required T value})
      : _controller = ValueNotifier<T>(value),
        _previous = value;
  T _previous;
  void add(T value, {bool savePrevious = true}) {
    if (savePrevious) _previous = _controller.value;
    _controller.value = value;
  }

  T get value => _controller.value;
  ValueNotifier<T> get stream => _controller;
  T get previous => _previous;
  void dispose() {
    _controller.dispose();
  }

  @override
  String toString() {
    return _controller.value.toString();
  }
}
