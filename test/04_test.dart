import 'package:advent/advent.dart';
import 'package:advent/solution/solutions.dart';
import 'package:test/test.dart';

Advent _advent(String input) {
  return adventForDay(4)..init(["$input-$input"]);
}

Future main() async {
  group("part two", () {
    test("c0", () => expect(_advent("112233").solveTwo(), completion(1)));
    test("c1", () => expect(_advent("123444").solveTwo(), completion(0)));
    test("c2", () => expect(_advent("111122").solveTwo(), completion(1)));
  });
}
