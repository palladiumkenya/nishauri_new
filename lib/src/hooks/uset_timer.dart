import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef OnTick = void Function(int remainingTime);
typedef OnComplete = void Function();

int _durationToSeconds(Duration duration) => duration.inSeconds;

Duration _secondsToDuration(int seconds) => Duration(seconds: seconds);

// Custom hook for countdown timer
class CountdownTimer {
  final int remainingTime;
  final VoidCallback reset;

  const CountdownTimer(this.remainingTime, this.reset);
}

CountdownTimer useTime(Duration duration, {OnTick? onTick, OnComplete? onComplete}) {
  final remainingTime = useState(_durationToSeconds(duration));
  Timer? _timer;

  void tick() {
    if (remainingTime.value > 0) {
      remainingTime.value--;
      onTick?.call(remainingTime.value);
    } else {
      _timer?.cancel();
      onComplete?.call();
    }
  }

  useEffect(() {
    _timer = Timer.periodic(_secondsToDuration(1), (_) => tick());
    return _timer?.cancel;
  }, [duration, onTick, onComplete]);

  void resetTimer() {
    remainingTime.value = _durationToSeconds(duration);
    _timer?.cancel();
    _timer = Timer.periodic(_secondsToDuration(1), (_) => tick());
  }

  return CountdownTimer(remainingTime.value, resetTimer);
}
