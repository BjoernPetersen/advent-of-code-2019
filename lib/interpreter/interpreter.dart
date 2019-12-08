import 'package:advent/interpreter/instruction.dart';
import 'package:advent/interpreter/io.dart';

class Interpreter {
  Future<int> execute(
    List<int> initialState, {
    Map<int, int> substitutions,
    IO io,
  }) async {
    final program = List.of(initialState, growable: false);
    substitutions?.forEach((index, value) => program[index] = value);
    var pc = 0;
    io ??= StaticIO([]);
    while (pc > -1) {
      final instruction = Instruction.atIndex(program, pc);
      pc = await instruction.execute(io);
    }
    return program[0];
  }
}

class Result {
  final int positionZero;
  final List<int> outputs;

  Result(this.positionZero, List<int> outputs)
      : outputs = List.unmodifiable(outputs);
}
