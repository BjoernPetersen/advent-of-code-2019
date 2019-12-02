import 'package:advent/advent.dart';

class Solution2 extends Advent<List<int>, int, int> {
  List<int> get program => input.first;

  @override
  List<int> readInputLine(String line) {
    return line
        .splitOn(",".codeUnitAt(0))
        .map(int.parse)
        .toList(growable: false);
  }

  int _run(final List<int> program) {
    for (var index = 0; index < program.length; index += 4) {
      switch (program[index]) {
        case 99:
          return program[0];
        case 1:
          final left = program[program[index + 1]];
          final right = program[program[index + 2]];
          final position = program[index + 3];
          program[position] = left + right;
          break;
        case 2:
          final left = program[program[index + 1]];
          final right = program[program[index + 2]];
          final position = program[index + 3];
          program[position] = left * right;
          break;
        default:
          throw StateError("Unknown opcode: ${program[index]}");
      }
    }
  }

  @override
  Future<int> solveOne() async {
    final program = List.of(this.program, growable: false);
    program[1] = 12;
    program[2] = 2;
    return _run(program);
  }

  @override
  Future<int> solveTwo() async {
    for (int noun = 0; noun < 100; ++noun) {
      for (int verb = 0; verb < 100; ++verb) {
        final copy = List.of(program, growable: false);
        copy[1] = noun;
        copy[2] = verb;
        try {
          final result = _run(copy);
          if (result == 19690720) {
            return noun * 100 + verb;
          }
        } on StateError catch (err) {
          continue;
        }
      }
    }
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
