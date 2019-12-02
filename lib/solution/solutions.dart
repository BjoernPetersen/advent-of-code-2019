import 'package:advent/advent.dart';
import 'package:advent/solution/solution01.dart';
import 'package:advent/solution/solution02.dart';

Advent adventForDay(int day) {
  switch (day) {
    case 1:
      return Solution1();
    case 2:
      return Solution2();
    default:
      return null;
  }
}
