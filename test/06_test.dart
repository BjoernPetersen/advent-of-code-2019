import 'dart:convert';
import 'dart:io';

import 'package:advent/solution/solutions.dart';
import 'package:test/test.dart';

final _testInput1 = """
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
""";

final _testInput2 = """
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN
""";

Future<int> _solveOne(String input) async {
  final advent = adventForDay(6)..init(LineSplitter.split(input.trim()));
  return await advent.solveOne();
}

Future<int> _solveTwo(String input) async {
  final advent = adventForDay(6)..init(LineSplitter.split(input.trim()));
  return await advent.solveTwo();
}

Future<void> main() async {
  final input = (await File("input/06.txt").readAsString()).trim();
  group("Part one", () {
    test("Example", () => expect(_solveOne(_testInput1), completion(42)));
    test("Input", () => expect(_solveOne(input), completion(160040)));
  });

  group("Part two", () {
    test("Example", () => expect(_solveTwo(_testInput2), completion(4)));
    test("Input", () => expect(_solveTwo(input), completion(373)));
  });
}
