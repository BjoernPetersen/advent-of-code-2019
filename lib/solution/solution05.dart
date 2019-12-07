import 'package:advent/advent.dart';
import 'package:advent/interpreter/interpreter.dart';
import 'package:advent/interpreter/io.dart';
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
    final io = StaticIO([1]);
    await interpreter.execute(program, io: io);
    return io.output.last;
  }

  @override
  Future<int> solveTwo() async {
    final io = StaticIO([5]);
    await interpreter.execute(program, io: io);
    return io.output.last;
  }
}
