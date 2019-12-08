import 'dart:io';

import 'package:advent/advent.dart';
import 'package:advent/solution/solutions.dart';
import 'package:test/test.dart';

Advent adv(String input) {
  return adventForDay(7)..init([input]);
}

Future<void> main() async {
  final input = await File('input/07.txt').readAsString();
  test('Part one', () => expect(adv(input).solveOne(), completion(65464)));
  test('Part two', () => expect(adv(input).solveTwo(), completion(1518124)));
}
