import 'dart:collection';
import 'dart:math';

import 'package:advent/advent.dart';
import 'package:advent/image/point.dart';

class Solution3 extends Advent<Wire, int, int> {
  @override
  Wire readInputLine(String line) {
    return Wire.fromLine(line);
  }

  @override
  Future<int> solveOne() async {
    final wire1 = input[0];
    final wire2 = input[1];
    final minX = min(wire1.minX, wire2.minX);
    final minY = min(wire1.minY, wire2.minY);
    final canvas = Canvas(
      width: max(wire1.maxX, wire2.maxX) - minX + 1,
      height: max(wire1.maxY, wire2.maxY) - minY + 1,
      minX: minX,
      minY: minY,
    );

    final zero = Point();
    final intersections =
        input.expand(canvas.add).where((it) => it != zero).toSet();

    return intersections
        .map((p) => p.distance(Point()))
        .reduce((a, b) => min(a, b));
  }

  @override
  Future<int> solveTwo() async {
    final wire1 = input[0];
    final wire2 = input[1];
    final minX = min(wire1.minX, wire2.minX);
    final minY = min(wire1.minY, wire2.minY);
    final canvas = Canvas(
      width: max(wire1.maxX, wire2.maxX) - minX + 1,
      height: max(wire1.maxY, wire2.maxY) - minY + 1,
      minX: minX,
      minY: minY,
    );

    final zero = Point();
    final intersections =
        input.expand(canvas.add).where((it) => it != zero).toSet();

    return intersections
        .map((p) => _sumStepDistance(p, wire1, wire2))
        .reduce((a, b) => min(a, b));
  }
}

int _sumStepDistance(Point inter, Wire a, Wire b) {
  return _stepDistance(inter, a) + _stepDistance(inter, b);
}

int _stepDistance(Point p, Wire w) {
  var distance = 0;
  for (final line in w.lines) {
    if (line.contains(p)) {
      distance += Line(line.start, p).length;
      return distance;
    } else {
      distance += line.length;
    }
  }
  throw ArgumentError();
}

class Canvas {
  final int width, height;
  final List<List<Set<Wire>>> _fields;
  final int minX, minY;

  Canvas({this.width, this.height, this.minX, this.minY})
      : _fields = List(height);

  Set<Point> add(Wire wire) {
    final overlap = <Point>{};
    for (final line in wire.lines) {
      final start = line.start;
      final end = line.end;
      final startY = min(start.y, end.y);
      final endY = max(start.y, end.y);
      for (var y = startY; y <= endY; ++y) {
        var row = _fields[y - minY];
        if (row == null) {
          row = List(width);
          _fields[y - minY] = row;
        }
        final startX = min(start.x, end.x);
        final endX = max(start.x, end.x);
        for (var x = startX; x <= endX; ++x) {
          var field = row[x - minX];
          if (field == null) {
            field = HashSet();
            row[x - minX] = field;
            field.add(wire);
          } else if (field.add(wire)) {
            overlap.add(Point(x: x, y: y));
          }
        }
      }
    }
    return overlap;
  }

  Set<int> get(int x, int y) {
    final row = _fields[y];
    if (row == null) return {};
    return row[x] ?? {};
  }

  @override
  String toString() {
    final buffer = StringBuffer();
    for (var y = 0; y < height; ++y) {
      final row = _fields[y];
      for (var x = 0; x < width; ++x) {
        if (row == null) {
          buffer.write('.');
        } else {
          final wires = row[x];
          if (wires == null) {
            buffer.write('.');
          } else if (wires.length > 1) {
            buffer.write('X');
          } else {
            buffer.write('+');
          }
        }
      }
      buffer.writeln();
    }
    return buffer.toString();
  }
}

class Line {
  final Point start;
  final Point end;

  Line(this.start, this.end);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Line &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  String toString() {
    return '$start -> $end';
  }

  bool contains(Point p) {
    final minX = min(start.x, end.x);
    final minY = min(start.y, end.y);
    final maxX = max(start.x, end.x);
    final maxY = max(start.y, end.y);
    return p.x >= minX && p.x <= maxX && p.y >= minY && p.y <= maxY;
  }

  int get length => start.distance(end).abs();
}

class Wire {
  final Set<Line> lines;
  final int minX;
  final int minY;
  final int maxX;
  final int maxY;

  Wire(this.lines, this.maxX, this.maxY, this.minX, this.minY);

  factory Wire.fromLine(String line) {
    final lines = <Line>{};
    var maxX = 0;
    var maxY = 0;
    var minX = 0;
    var minY = 0;
    var pos = Point(x: 0, y: 0);
    for (final value in line.split(',')) {
      final added = _line(pos, value);
      lines.add(added);
      pos = added.end;
      maxX = max(pos.x, maxX);
      maxY = max(pos.y, maxY);
      minX = min(pos.x, minX);
      minY = min(pos.y, minY);
    }
    return Wire(lines, maxX, maxY, minX, minY);
  }

  static Line _line(Point start, String value) {
    final direction = value.substring(0, 1);
    final length = int.parse(value.substring(1));
    switch (direction) {
      case 'R':
        return Line(start, start + Point(x: length));
      case 'U':
        return Line(start, start - Point(y: length));
      case 'L':
        return Line(start, start - Point(x: length));
      case 'D':
        return Line(start, start + Point(y: length));
      default:
        throw ArgumentError('Unknown direction: $direction');
    }
  }
}
