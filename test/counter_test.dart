import 'package:ragersneakers/counter.dart';
import 'package:test/test.dart';

void main() {
  test('Le compteur doit être incrémenté', () {
    final counter = Counter();
    counter.increment();
    expect(counter.value, 1);
  });

  group('Test start, increment, decrement', (){
    test('Value should start at zero', () {
      expect(Counter().value, 0);
    });

    test('Value should be incremented', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });

    test('Value should be decremented', () {
      final counter = Counter();
      counter.decrement();
      expect(counter.value, -1);
    });
  });
}