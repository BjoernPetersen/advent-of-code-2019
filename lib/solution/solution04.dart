import 'package:advent/advent.dart';

class Solution4 extends Advent<Range, int, int> {
  Range get range => input.first;

  @override
  Range readInputLine(String line) {
    final split = line.split("-");
    return Range(int.parse(split[0]), int.parse(split[1]));
  }

  bool _meetsCriteria1(int pass) {
    final str = pass.toString();
    bool foundDouble = false;
    var last = -1;
    for (var numIndex = 0; numIndex < str.length; ++numIndex) {
      final num = int.parse(str.substring(numIndex, numIndex + 1));
      if (num < last) return false;
      if (num == last) {
        foundDouble = true;
      }
      last = num;
    }
    return foundDouble;
  }

  bool _meetsCriteria2(int pass) {
    final str = pass.toString();
    bool foundDouble = false;
    var last3 = -3;
    var last2 = -2;
    var last = -1;
    for (var numIndex = 0; numIndex < str.length; ++numIndex) {
      final num = int.parse(str.substring(numIndex, numIndex + 1));
      if (num < last) return false;
      if (num != last && last == last2 && last2 != last3) {
        foundDouble = true;
      }
      last3 = last2;
      last2 = last;
      last = num;
    }

    if (last == last2 && last2 != last3) {
      return true;
    }
    return foundDouble;
  }

  @override
  Future<int> solveOne() async {
    final range = this.range;
    var count = 0;
    for (var cand = range.min; cand <= range.max; ++cand) {
      if (_meetsCriteria1(cand)) ++count;
    }
    return count;
  }

  @override
  Future<int> solveTwo() async {
    final range = this.range;
    var count = 0;
    for (var cand = range.min; cand <= range.max; ++cand) {
      if (_meetsCriteria2(cand)) ++count;
    }
    return count;
  }
}

class Range {
  final int min;
  final int max;

  Range(this.min, this.max);

  bool contains(int candidate) {
    return candidate >= min && candidate <= max;
  }
}
