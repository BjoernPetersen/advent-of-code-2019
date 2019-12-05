import 'package:advent/solution/solution05.dart';
import 'package:advent/solution/solutions.dart';
import 'package:test/test.dart';

Future<int> _advent(String program, int input) async {
  final adv = adventForDay(5)..init([program]);
  final sol = adv as Solution5;
  return await sol.solve([input]);
}

Future main() async {
  group("part one", () {
    test("equal 8",
        () => expect(_advent("3,9,8,9,10,9,4,9,99,-1,8", 8), completion(1)));
    test("not equal 8",
        () => expect(_advent("3,9,8,9,10,9,4,9,99,-1,8", 6), completion(0)));
  });

//  group("part two", () {
//    test(
//      "t1",
//        () => expect(
//        _advent([
//          "R75,D30,R83,U83,L12,D49,R71,U7,L72",
//          "U62,R66,U55,R34,D71,R55,D58,R83"
//        ]).solveTwo(),
//        completion(159)));
//  });
}
