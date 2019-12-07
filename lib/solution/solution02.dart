import 'package:advent/advent.dart';
import 'package:advent/interpreter/interpreter.dart';
import 'package:advent/util/strings.dart';

class Solution2 extends Advent<List<int>, int, int> {
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
    return await interpreter.execute(
      program,
      substitutions: {
        1: 12,
        2: 2,
      },
    );
  }

  @override
  Future<int> solveTwo() async {
    for (int noun = 0; noun < 100; ++noun) {
      for (int verb = 0; verb < 100; ++verb) {
        try {
          final result = await interpreter.execute(
            program,
            substitutions: {
              1: noun,
              2: verb,
            },
          );
          if (result == 19690720) {
            return noun * 100 + verb;
          }
        } on StateError {
          continue;
        }
      }
    }
  }
}
