import 'dart:collection';

import 'package:advent/image/color.dart';
import 'package:advent/image/point.dart';

class Layer extends IterableBase<Color> {
  final int width, height;
  final List<List<Color>> _pixels;

  Layer(this.width, this.height, List<List<Color>> pixels) : _pixels = pixels;

  factory Layer.fromString(int width, int height, String spec) {
    final rows = List<List<Color>>(height);
    for (var y = 0; y < height; ++y) {
      final row = List<Color>(width);
      rows[y] = row;
      for (var x = 0; x < width; ++x) {
        final index = y * width + x;
        row[x] = color(int.parse(spec.substring(index, index + 1)));
      }
    }
    return Layer(width, height, rows);
  }

  Color get(int x, int y) {
    return _pixels[y][x];
  }

  Color operator [](Point point) => get(point.x, point.y);

  Iterable<Color> _allColors() sync* {
    for (var y = 0; y < height; ++y) {
      yield* _pixels[y];
    }
  }

  Iterable<Point> points() sync* {
    for (var y = 0; y < height; ++y) {
      for (var x = 0; x < width; ++x) {
        yield Point(x: x, y: y);
      }
    }
  }

  @override
  int get length => _pixels.length;

  @override
  Iterator<Color> get iterator => _allColors().iterator;
}
