import 'package:advent/advent.dart';
import 'package:advent/image/color.dart';
import 'package:advent/image/image.dart';
import 'package:advent/image/layer.dart';
import 'package:advent/util/counter.dart';

class Solution8 extends Advent<Image, int, String> {
  @override
  Image readInputLine(String line) {
    return Image.fromString(25, 6, line.trim());
  }

  @override
  Future<int> solveOne() async {
    Layer min;
    final counts = <Layer, Map<Color, int>>{};
    for (final layer in single.layers) {
      final count = Counter.count(layer);
      counts[layer] = count;
      if (min == null || count[Color.black] < counts[min][Color.black]) {
        min = layer;
      }
    }

    final count = counts[min];
    return count[Color.white] * count[Color.transparent];
  }

  @override
  Future<String> solveTwo() async {
    return '\n$single';
  }
}
