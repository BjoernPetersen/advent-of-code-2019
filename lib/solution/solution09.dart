import 'package:advent/advent.dart';
import 'package:advent/interpreter/interpreter.dart';
import 'package:advent/interpreter/io.dart';
import 'package:advent/interpreter/util.dart';

class Solution9 extends Advent<List<int>, int, int> {
  @override
  List<int> readInputLine(String line) {
    return readProgramLine(line);
  }

  @override
  Future<int> solveOne() async {
    final io = StaticIO([1]);
    await Interpreter().execute(single, io: io);
    return io.output.single;
  }

  @override
  Future<int> solveTwo() async {
    final io = StaticIO([2]);
    await Interpreter().execute(single, io: io);
    return io.output.single;
  }
}
