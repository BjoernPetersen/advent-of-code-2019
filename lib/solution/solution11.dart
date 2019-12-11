import 'dart:math';

import 'package:advent/advent.dart';
import 'package:advent/image/canvas.dart';
import 'package:advent/image/color.dart';
import 'package:advent/image/point.dart';
import 'package:advent/interpreter/interpreter.dart';
import 'package:advent/interpreter/io.dart';
import 'package:advent/interpreter/util.dart';

class Solution11 extends Advent<List<int>, int, String> {
  @override
  List<int> readInputLine(String line) {
    return readProgramLine(line);
  }

  Function(int) _switchingOutputAction(final Robot robot) {
    var isPaint = true;
    void handleOutput(int code) {
      if (isPaint) {
        robot.paint(code.isWhite);
      } else {
        robot.turnAndMove(code.isRight);
      }
      isPaint = !isPaint;
    }

    return handleOutput;
  }

  Future<void> _run(Hull hull, Robot robot) async {
    final io = WiredIO(
      input: () async => robot.getColor().code,
      output: _switchingOutputAction(robot),
    );

    await Interpreter().execute(single, io: io);
  }

  @override
  Future<int> solveOne() async {
    final hull = Hull();
    final robot = Robot(hull);
    await _run(hull, robot);
    return hull.paintedCount;
  }

  @override
  Future<String> solveTwo() async {
    final hull = Hull();
    final robot = Robot(hull);
    robot.paint(true);
    await _run(hull, robot);

    return '\n' + hull.toCanvas().toString();
  }
}

class Hull {
  final _painted = <Point, bool>{};

  bool operator [](Point point) => _painted[point] ?? false;

  operator []=(Point point, bool white) => _painted[point] = white;

  int get paintedCount => _painted.length;

  Canvas toCanvas() {
    var minX = 999999, maxX = 0, minY = 999999, maxY = 0;
    for (final point in _painted.keys) {
      minX = min(minX, point.x);
      minY = min(minY, point.y);
      maxX = max(maxX, point.x);
      maxY = max(maxY, point.y);
    }

    final canvas = Canvas(
      width: maxX - minX + 1,
      height: maxY - minY + 1,
      minX: minX,
      minY: minY,
    );

    for (final entry in _painted.entries) {
      final pos = entry.key;
      canvas.paint(pos.x, pos.y, entry.value ? Color.white : Color.black);
    }

    return canvas;
  }
}

class Robot {
  final Hull hull;
  Point _position;
  Direction _direction;

  Robot(
    this.hull, [
    Point startPosition = const Point(),
    Direction startDirection = Direction.up,
  ]) {
    _position = startPosition;
    _direction = startDirection;
  }

  bool getColor() => hull[_position];

  void paint(bool white) {
    hull[_position] = white;
  }

  void turnAndMove(bool turnRight) {
    _direction = _direction.turn(turnRight);
    _position = _position.move(_direction);
  }
}

enum Direction { up, right, down, left }

extension on Direction {
  Direction turn(bool turnRight) {
    final values = Direction.values;
    if (turnRight) {
      return values[(index + 1) % values.length];
    } else {
      return values[index == 0 ? values.length - 1 : index - 1];
    }
  }
}

extension on Point {
  // ignore: missing_return
  Point move(Direction direction) {
    switch (direction) {
      case Direction.up:
        return this + Point(y: -1);
      case Direction.down:
        return this + Point(y: 1);
      case Direction.left:
        return this + Point(x: -1);
      case Direction.right:
        return this + Point(x: 1);
    }
  }
}

extension on int {
  bool get isWhite => this == 1;

  bool get isRight => this == 1;
}

extension on bool {
  int get code => this ? 1 : 0;
}
