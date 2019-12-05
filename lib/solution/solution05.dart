import 'dart:math';

import 'package:advent/advent.dart';

class Solution5 extends Advent<List<int>, int, int> {
  List<int> get program => input.first;

  @override
  List<int> readInputLine(String line) {
    return line
        .splitOn(",".codeUnitAt(0))
        .map(int.parse)
        .toList(growable: false);
  }

  int getParam(List<int> program, int pc, String op, int paramNum, {int mode}) {
    int index = op.length - 2 - paramNum;
    if (mode == null) {
      mode = index >= 0 ? int.parse(op.substring(index, index + 1)) : 0;
    }
    int value = program[pc + paramNum];
    switch (mode) {
      case 0:
        return program[value];
      case 1:
        return value;
    }
  }

  List<int> _run(final List<int> program, final Iterator<int> inputs) {
    final List<int> outputs = List();
    var pc = 0;
    while (true) {
      final fullOpCode = program[pc];
      final op = fullOpCode.toString();
      final opCode = int.parse(op.substring(op.length - min(2, op.length)));
      switch (opCode) {
        case 99:
          // technically should return program[0]
          return outputs;
        case 1:
          final left = getParam(program, pc, op, 1);
          final right = getParam(program, pc, op, 2);
          final position = program[pc + 3];
          program[position] = left + right;
          pc += 4;
          break;
        case 2:
          final left = getParam(program, pc, op, 1);
          final right = getParam(program, pc, op, 2);
          final position = program[pc + 3];
          program[position] = left * right;
          pc += 4;
          break;
        case 3:
          final address = program[pc + 1];
          final moved = inputs.moveNext();
          assert(moved);
          final input = inputs.current;
          program[address] = input;
          pc += 2;
          break;
        case 4:
          final address = program[pc + 1];
          final output = program[address];
          outputs.add(output);
          pc += 2;
          break;
        case 5:
          final cond = getParam(program, pc, op, 1);
          if (cond != 0) {
            pc = getParam(program, pc, op, 2);
          } else {
            pc += 3;
          }
          break;
        case 6:
          final cond = getParam(program, pc, op, 1);
          if (cond == 0) {
            pc = getParam(program, pc, op, 2);
          } else {
            pc += 3;
          }
          break;
        case 7:
          final left = getParam(program, pc, op, 1);
          final right = getParam(program, pc, op, 2);
          final result = left < right ? 1 : 0;
          final address = program[pc + 3];
          program[address] = result;
          pc += 4;
          break;
        case 8:
          final left = getParam(program, pc, op, 1);
          final right = getParam(program, pc, op, 2);
          final result = left == right ? 1 : 0;
          final address = program[pc + 3];
          program[address] = result;
          pc += 4;
          break;
        default:
          throw StateError("Unknown opcode: ${program[pc]}");
      }
    }
  }

  Future<int> solve(List<int> inputs) async {
    return _run(program, inputs.iterator).first;
  }

  @override
  Future<int> solveOne() async {
    return _run(List.of(program), [1].iterator).last;
  }

  @override
  Future<int> solveTwo() async {
    return _run(List.of(program), [5].iterator).last;
  }
}

extension on String {
  Iterable<String> splitOn(final int splitOn) sync* {
    for (var index = 0; index < this.length; ++index) {
      final codeUnit = this.codeUnitAt(index);
      if (codeUnit == splitOn) {
        yield this.substring(0, index);
        if (index != length - 1) {
          yield* this.substring(index + 1).splitOn(splitOn);
        }
        return;
      }
    }
    yield this;
  }
}
