import 'package:advent/interpreter/instruction.dart';
import 'package:advent/interpreter/io.dart';

class Interpreter {
  Future<Result> execute(List<int> initialState,
      {Map<int, int> substitutions, List<int> input}) async {
    final program = List.of(initialState, growable: false);
    substitutions?.forEach((index, value) => program[index] = value);
    var pc = 0;
    final io = IO(input ?? List());
    while (pc > -1) {
      final instruction = Instruction.atIndex(program, pc);
      pc = instruction.execute(io);
    }
    return Result(program[0], io.output);
  }
}

class Result {
  final int positionZero;
  final List<int> outputs;

  Result(this.positionZero, List<int> outputs)
      : this.outputs = List.unmodifiable(outputs);
}
