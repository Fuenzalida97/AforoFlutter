import 'package:test/test.dart';
import 'package:aforo_app/controllers/counter.dart';

void main(){
  group('Counter', ()
  {
    test('el valor debiese empezar en 0', () {
      expect(Counter().value, 0);
    });

    test('el valor debiese ser incrementado', () {
      final counter = Counter();

      counter.increment();
      expect(counter.value, 1);
    });

    test('el valor debiese ser decrementado', () {
      final counter = Counter();

      counter.decrement();
      expect(counter.value, -1);
    });
  });
}