import 'package:advent/advent.dart';
import 'package:advent/solution/solution01.dart';
import 'package:advent/solution/solution02.dart';
import 'package:advent/solution/solution03.dart';
import 'package:advent/solution/solution04.dart';
import 'package:advent/solution/solution05.dart';
import 'package:advent/solution/solution06.dart';
import 'package:advent/solution/solution08.dart';

Advent adventForDay(int day) {
  switch (day) {
    case 1:
      return Solution1();
    case 2:
      return Solution2();
    case 3:
      return Solution3();
    case 4:
      return Solution4();
    case 5:
      return Solution5();
    case 6:
      return Solution6();
    case 8:
      return Solution8();
    default:
      return null;
  }
}
