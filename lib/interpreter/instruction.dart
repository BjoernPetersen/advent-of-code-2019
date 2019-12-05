import 'dart:math';

import 'package:advent/interpreter/io.dart';

abstract class Instruction {
  final List<int> program;
  final int index;

  Instruction(this.program, this.index);

  factory Instruction.atIndex(List<int> program, int index) {
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
      default:
        throw ArgumentError("Unknown opcode: $opCode");
    }
  }

  int execute(IO io);

  int getParameter(final int num, [ParameterMode mode]) {
    if (mode == null) {
      final opInfo = program[index];
      mode = ParameterMode.values[opInfo[num + 1]];
    }
    int value = program[index + num];
    switch (mode) {
      case ParameterMode.position:
        return program[value];
      case ParameterMode.immediate:
        return value;
    }
  }
}

class ExitInstruction extends Instruction {
  ExitInstruction(List<int> program, int index) : super(program, index);

  @override
  int execute(IO io) {
    return -1;
  }
}

class AddInstruction extends Instruction {
  AddInstruction(List<int> program, int index) : super(program, index);

  @override
  int execute(IO io) {
    final left = getParameter(1);
    final right = getParameter(2);
    final position = getParameter(3, ParameterMode.immediate);
    program[position] = left + right;
    return index + 4;
  }
}

class MultiplyInstruction extends Instruction {
  MultiplyInstruction(List<int> program, int index) : super(program, index);

  @override
  int execute(IO io) {
    final left = getParameter(1);
    final right = getParameter(2);
    final position = getParameter(3, ParameterMode.immediate);
    program[position] = left * right;
    return index + 4;
  }
}

class InputInstruction extends Instruction {
  InputInstruction(List<int> program, int index) : super(program, index);

  @override
  int execute(IO io) {
    final position = getParameter(1, ParameterMode.immediate);
    program[position] = io.read();
    return index + 2;
  }
}

class OutputInstruction extends Instruction {
  OutputInstruction(List<int> program, int index) : super(program, index);

  @override
  int execute(IO io) {
    final value = getParameter(1);
    io.write(value);
    return index + 2;
  }
}

class NonZeroJumpInstruction extends Instruction {
  NonZeroJumpInstruction(List<int> program, int index) : super(program, index);

  @override
  int execute(IO io) {
    final cond = getParameter(1);
    if (cond != 0) {
      return getParameter(2);
    } else {
      return index + 3;
    }
  }
}

class ZeroJumpInstruction extends Instruction {
  ZeroJumpInstruction(List<int> program, int index) : super(program, index);

  @override
  int execute(IO io) {
    final cond = getParameter(1);
    if (cond == 0) {
      return getParameter(2);
    } else {
      return index + 3;
    }
  }
}

class LessThanInstruction extends Instruction {
  LessThanInstruction(List<int> program, int index) : super(program, index);

  @override
  int execute(IO io) {
    final left = getParameter(1);
    final right = getParameter(2);
    final position = getParameter(3, ParameterMode.immediate);
    program[position] = left < right ? 1 : 0;
    return index + 4;
  }
}

class EqualsInstruction extends Instruction {
  EqualsInstruction(List<int> program, int index) : super(program, index);

  @override
  int execute(IO io) {
    final left = getParameter(1);
    final right = getParameter(2);
    final position = getParameter(3, ParameterMode.immediate);
    program[position] = left == right ? 1 : 0;
    return index + 4;
  }
}

extension on int {
  int operator [](int index) => digitAt(index);

  int digitAt(int index, {int length = 1}) {
    return (this % pow(10, index + 1 * length)) ~/ pow(10, index);
  }
}

enum ParameterMode { position, immediate }
