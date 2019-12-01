import 'package:advent/solution/solutions.dart';
import 'package:test/test.dart';

Future<int> solveOne(List<String> input) async {
  final advent = adventForDay(1)..init(input);
  final solution = await advent.solveOne();
  return int.parse(solution);
}

Future<int> solveTwo(List<String> input) async {
  final advent = adventForDay(1)..init(input);
  final solution = await advent.solveTwo();
  return int.parse(solution);
}

void main() {
  test("one for 12", () => expect(solveOne(["12"]), completion(2)));
  test("one for 14", () => expect(solveOne(["14"]), completion(2)));
  test("one for 1969", () => expect(solveOne(["1969"]), completion(654)));
  test("one for 100756", () => expect(solveOne(["100756"]), completion(33583)));
  test("one are summed", () => expect(solveOne(["12", "14"]), completion(4)));

  test("two for 14", () => expect(solveTwo(["14"]), completion(2)));
  test("two for 1969", () => expect(solveTwo(["1969"]), completion(966)));
  test("two for 100756", () => expect(solveTwo(["100756"]), completion(50346)));
}
