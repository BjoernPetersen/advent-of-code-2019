import 'package:advent/advent.dart';
import 'package:advent/solution/solution01.dart' as solution1;

Advent adventForDay(int day) {
  switch (day) {
    case 1:
      return solution1.Solution();
    default:
      return null;
  }
}
