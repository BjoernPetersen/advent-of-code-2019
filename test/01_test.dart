import 'package:advent/solution/solutions.dart';
import 'package:test/test.dart';

Future<int> solveOne(List<String> input) async {
  final advent = adventForDay(1)..init(input);
  return await advent.solveOne();
}

Future<int> solveTwo(List<String> input) async {
  final advent = adventForDay(1)..init(input);
  return await advent.solveTwo();
}

void main() {
  group('part one', () {
    test('for 12', () => expect(solveOne(['12']), completion(2)));
    test('for 14', () => expect(solveOne(['14']), completion(2)));
    test('for 1969', () => expect(solveOne(['1969']), completion(654)));
    test('for 100756', () => expect(solveOne(['100756']), completion(33583)));
    test('are summed', () => expect(solveOne(['12', '14']), completion(4)));
  });

  group('part two', () {
    test('for 14', () => expect(solveTwo(['14']), completion(2)));
    test('for 1969', () => expect(solveTwo(['1969']), completion(966)));
    test('for 100756', () => expect(solveTwo(['100756']), completion(50346)));
  });
}
