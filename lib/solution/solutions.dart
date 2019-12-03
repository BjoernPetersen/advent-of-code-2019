import 'package:advent/advent.dart';
import 'package:advent/solution/solution01.dart';
import 'package:advent/solution/solution02.dart';
import 'package:advent/solution/solution03.dart';

Advent adventForDay(int day) {
  switch (day) {
    case 1:
      return Solution1();
    case 2:
      return Solution2();
    case 3:
      return Solution3();
    default:
      return null;
  }
}
