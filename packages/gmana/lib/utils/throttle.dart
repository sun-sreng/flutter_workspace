import 'dart:async';

/// Default throttle time in milliseconds.
const kDefaultThrottlerDuration = 300;

/// A small utility to throttle function execution.
class Throttle {
  /// Throttle delay in milliseconds.
  final int milliseconds;

  Timer? _timer;

  /// Creates a throttler with the provided [milliseconds] window.
  Throttle({this.milliseconds = kDefaultThrottlerDuration});

  /// Cancels the active throttle window.
  void dispose() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
  }

  /// Runs [action] immediately if not currently throttled.
  void run(void Function() action) {
    if (_timer?.isActive ?? false) return;

    action();
    _timer = Timer(Duration(milliseconds: milliseconds), () {});
  }
}

/// Extension that throttles a callback inline.
extension ThrottleFunction on void Function() {
  /// Runs this callback through a newly created throttler.
  void throttle({int milliseconds = kDefaultThrottlerDuration}) {
    final throttler = Throttle(milliseconds: milliseconds);
    throttler.run(call);
  }
}
