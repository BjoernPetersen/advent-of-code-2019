import 'package:advent/advent.dart';
import 'package:advent/solution/solutions.dart';
import 'package:test/test.dart';

Advent _advent(String input) {
  return adventForDay(2)..init([input]);
}

Future main() async {
  group("part one", () {
    test("test", () => expect(_advent("1,9,10,3,2,3,11,0,99,30,40,50").solveOne(), completion(3500)));
  });
}
