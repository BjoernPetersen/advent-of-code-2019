import 'package:advent/advent.dart';
import 'package:advent/interpreter/interpreter.dart';
import 'package:advent/util/strings.dart';

class Solution5 extends Advent<List<int>, int, int> {
  List<int> get program => input.first;
  final interpreter = Interpreter();

  @override
  List<int> readInputLine(String line) {
    return line
        .splitOn(",".codeUnitAt(0))
        .map(int.parse)
        .toList(growable: false);
  }

  @override
  Future<int> solveOne() async {
    final result = await interpreter.execute(program, input: [1]);
    return result.outputs.last;
  }

  @override
  Future<int> solveTwo() async {
    final result = await interpreter.execute(program, input: [5]);
    return result.outputs.last;
  }
}
