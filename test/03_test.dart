import 'package:advent/advent.dart';
import 'package:advent/solution/solutions.dart';
import 'package:test/test.dart';

Advent _advent(List<String> input) {
  return adventForDay(3)..init(input);
}

Future main() async {
  group("part one", () {
    test(
        "test",
        () => expect(
            _advent([
              "R75,D30,R83,U83,L12,D49,R71,U7,L72",
              "U62,R66,U55,R34,D71,R55,D58,R83"
            ]).solveOne(),
            completion(159)));
  });

  group("part two", () {
    test(
      "simple",
        () => expect(
        _advent([
          "R8,U5,L5,D3",
          "U7,R6,D4,L4"
        ]).solveTwo(),
        completion(30)));
    test(
        "c1",
        () => expect(
            _advent([
              "R75,D30,R83,U83,L12,D49,R71,U7,L72",
              "U62,R66,U55,R34,D71,R55,D58,R83"
            ]).solveTwo(),
            completion(610)));
    test(
        "c2",
        () => expect(
            _advent([
              "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
              "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
            ]).solveTwo(),
            completion(410)));
  });
}
