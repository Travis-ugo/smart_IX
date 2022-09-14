import 'package:flutter_test/flutter_test.dart';
import 'package:smart_ix/smart_ix/domain/automated_timer/auto_ticker.dart';

void main() {
  group('Ticker', () {
    const ticker = Ticker();

    test('emits 3 ticks from 2 - 0 every second', () {
      expectLater(ticker.tick(ticks: 3), emitsInOrder(<int>[2, 1, 0]));
    });
  });
}
