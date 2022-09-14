import 'package:flutter_test/flutter_test.dart';
import 'package:smart_ix/smart_ix/application/automated_timer/timer/timer_bloc.dart';

void main() {
  group("Timer event", () {
    group('TimerStarted', () {
      test('support value comparison', () {
        expect(
            const TimerStarted(duration: 50), const TimerStarted(duration: 50));
      });
    });
    group('TimerPaused', () {
      test('support value comparison', () {
        expect(const TimerPaused(), const TimerPaused());
      });
    });

    group('TimerResumed', () {
      test('support value comparison', () {
        expect(const TimerResumed(), const TimerResumed());
      });
    });

    group('TimerReset', () {
      test('support value comparison', () {
        expect(const TimerReset(), const TimerReset());
      });
    });
    group('TimerTicker', () {
      test('support value comparison', () {
        expect(
            const TimerTicked(duration: 60), const TimerTicked(duration: 60));
      });
    });
  });
}
