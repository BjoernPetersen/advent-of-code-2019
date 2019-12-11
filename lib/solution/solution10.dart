import 'dart:math';

import 'package:advent/advent.dart';
import 'package:advent/image/color.dart';
import 'package:advent/image/layer.dart';

class Solution10 extends Advent<List<Color>, int, int> {
  final _colorBySymbol = {
    '.'.codeUnits.single: Color.white,
    '#'.codeUnits.single: Color.black,
  };
  int _width;
  int _height = 0;
  Layer _layer;

  @override
  void init(Iterable<String> input) {
    super.init(input);
    _layer = Layer(_width, _height, this.input);
  }

  @override
  List<Color> readInputLine(String line) {
    _width = line.length;
    ++_height;
    return line.codeUnits.map((u) => _colorBySymbol[u]).toList(growable: false);
  }

  @override
  Future<int> solveOne() async {
    // FIXME: I severely misunderstood the objective
    final asteroids =
        _layer.points().where((point) => _layer[point] == Color.black).toSet();
    var maxDetected = 0;
    for (final point in asteroids) {
      var detected = 0;
      for (final other in asteroids.where((p) => p != point)) {
        final xRest = (point.x + other.x) % 2;
        final yRest = (point.y + other.y) % 2;
        if (xRest > 0 || yRest > 0) {
          ++detected;
        } else {
          final x = (point.x + other.x) ~/ 2;
          final y = (point.y + other.y) ~/ 2;
          if (_layer.get(x, y) != Color.black) {
            ++detected;
          }
        }
      }

      maxDetected = max(maxDetected, detected);
    }

    return maxDetected;
  }

  @override
  Future<int> solveTwo() async {
    // TODO: implement solveTwo
    return null;
  }
}
