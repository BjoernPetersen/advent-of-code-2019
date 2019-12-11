import 'dart:math';

import 'package:advent/advent.dart';
import 'package:advent/interpreter/interpreter.dart';
import 'package:advent/interpreter/io.dart';
import 'package:advent/interpreter/util.dart';

class Solution7 extends Advent<List<int>, int, int> {
  List<int> get program => input.first;

  @override
  List<int> readInputLine(String line) {
    return readProgramLine(line);
  }

  Future<int> _amplifySimple(List<int> phases) async {
    final interpreter = Interpreter();
    var value = 0;
    for (final phase in phases) {
      final io = StaticIO([phase, value]);
      await interpreter.execute(program, io: io);
      value = io.output.last;
    }
    return value;
  }

  Iterable<List<int>> phaseSettings(int from) sync* {
    final to = from + 4;
    for (var a = from; a <= to; ++a) {
      for (var b = from; b <= to; ++b) {
        if (b == a) continue;
        for (var c = from; c <= to; ++c) {
          if (c == a || c == b) continue;
          for (var d = from; d <= to; ++d) {
            if (d == a || d == b || d == c) continue;
            for (var e = from; e <= to; ++e) {
              if (e == a || e == b || e == c || e == d) continue;
              yield [a, b, c, d, e];
            }
          }
        }
      }
    }
  }

  @override
  Future<int> solveOne() async {
    var maxValue = 0;
    for (final phase in phaseSettings(0)) {
      maxValue = max(maxValue, await _amplifySimple(phase));
    }
    return maxValue;
  }

  Future<int> _amplifyFeedback(List<int> phases) async {
    final interpreter = Interpreter();
    final ios = List<StreamIO>(5);
    for (var amp = 0; amp < 5; ++amp) {
      final io = StreamIO();
      ios[amp] = io;
      io.addInput(phases[amp]);
    }

    ios[0].addInput(0);
    ios[0].listen(ios[1].addInput);
    ios[1].listen(ios[2].addInput);
    ios[2].listen(ios[3].addInput);
    ios[3].listen(ios[4].addInput);
    ios[4].listen(ios[0].addInput);

    await Future.wait(ios.map((io) => interpreter.execute(program, io: io)));
    return ios[4].lastOutput;
  }

  @override
  Future<int> solveTwo() async {
    var maxThrust = 0;
    for (final phaseSetting in phaseSettings(5)) {
      final thrust = await _amplifyFeedback(phaseSetting);
      maxThrust = max(maxThrust, thrust);
    }

    return maxThrust;
  }
}
