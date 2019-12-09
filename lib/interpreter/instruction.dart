import 'package:advent/interpreter/io.dart';
import 'package:advent/interpreter/program.dart';
import 'package:advent/util/ints.dart';

abstract class Instruction {
  final Program program;
  final int index;

  Instruction(this.program, this.index);

  factory Instruction.atIndex(Program program, int index) {
    final opInfo = program[index];
    final opCode = opInfo.digitAt(0, length: 2);
    switch (opCode) {
      case 99:
        return ExitInstruction(program, index);
      case 1:
        return AddInstruction(program, index);
      case 2:
        return MultiplyInstruction(program, index);
      case 3:
        return InputInstruction(program, index);
      case 4:
        return OutputInstruction(program, index);
      case 5:
        return NonZeroJumpInstruction(program, index);
      case 6:
        return ZeroJumpInstruction(program, index);
      case 7:
        return LessThanInstruction(program, index);
      case 8:
        return EqualsInstruction(program, index);
      case 9:
        return RelativeAdjustInstruction(program, index);
      default:
        throw ArgumentError('Unknown opcode: $opCode');
    }
  }

  Future<int> execute(IO io);

  // ignore: missing_return
  int getParameter(final int num, [bool forWrite = false]) {
    final opInfo = program[index];
    final mode = ParameterMode.values[opInfo[num + 1]];
    final value = program[index + num];
    switch (mode) {
      case ParameterMode.position:
        return forWrite ? value : program[value];
      case ParameterMode.immediate:
        if (!forWrite) return value;
        throw ArgumentError();
      case ParameterMode.relative:
        final position = program.relativeBase + value;
        return forWrite ? position : program[position];
    }
  }
}

class ExitInstruction extends Instruction {
  ExitInstruction(Program program, int index) : super(program, index);

  @override
  Future<int> execute(IO io) async {
    return -1;
  }
}

class AddInstruction extends Instruction {
  AddInstruction(Program program, int index) : super(program, index);

  @override
  Future<int> execute(IO io) async {
    final left = getParameter(1);
    final right = getParameter(2);
    final position = getParameter(3, true);
    program[position] = left + right;
    return index + 4;
  }
}

class MultiplyInstruction extends Instruction {
  MultiplyInstruction(Program program, int index) : super(program, index);

  @override
  Future<int> execute(IO io) async {
    final left = getParameter(1);
    final right = getParameter(2);
    final position = getParameter(3, true);
    program[position] = left * right;
    return index + 4;
  }
}

class InputInstruction extends Instruction {
  InputInstruction(Program program, int index) : super(program, index);

  @override
  Future<int> execute(IO io) async {
    final position = getParameter(1, true);
    program[position] = await io.read();
    return index + 2;
  }
}

class OutputInstruction extends Instruction {
  OutputInstruction(Program program, int index) : super(program, index);

  @override
  Future<int> execute(IO io) async {
    final value = getParameter(1);
    io.write(value);
    return index + 2;
  }
}

class NonZeroJumpInstruction extends Instruction {
  NonZeroJumpInstruction(Program program, int index) : super(program, index);

  @override
  Future<int> execute(IO io) async {
    final cond = getParameter(1);
    if (cond != 0) {
      return getParameter(2);
    } else {
      return index + 3;
    }
  }
}

class ZeroJumpInstruction extends Instruction {
  ZeroJumpInstruction(Program program, int index) : super(program, index);

  @override
  Future<int> execute(IO io) async {
    final cond = getParameter(1);
    if (cond == 0) {
      return getParameter(2);
    } else {
      return index + 3;
    }
  }
}

class LessThanInstruction extends Instruction {
  LessThanInstruction(Program program, int index) : super(program, index);

  @override
  Future<int> execute(IO io) async {
    final left = getParameter(1);
    final right = getParameter(2);
    final position = getParameter(3, true);
    program[position] = left < right ? 1 : 0;
    return index + 4;
  }
}

class EqualsInstruction extends Instruction {
  EqualsInstruction(Program program, int index) : super(program, index);

  @override
  Future<int> execute(IO io) async {
    final left = getParameter(1);
    final right = getParameter(2);
    final position = getParameter(3, true);
    program[position] = left == right ? 1 : 0;
    return index + 4;
  }
}

class RelativeAdjustInstruction extends Instruction {
  RelativeAdjustInstruction(Program program, int index) : super(program, index);

  @override
  Future<int> execute(IO io) async {
    final offset = getParameter(1);
    program.relativeBase += offset;
    return index + 2;
  }
}

enum ParameterMode {
  position,
  immediate,
  relative,
}

ParameterMode getMode(int code, [bool forWrite]) {
  final values = ParameterMode.values;
  return values[forWrite ? (code + 1) % values.length : code];
}
