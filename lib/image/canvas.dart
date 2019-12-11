import 'package:advent/image/color.dart';

class Canvas {
  final int width, height;
  final List<List<Color>> _fields;
  final int minX, minY;
  final Color defaultColor;

  Canvas({
    this.width,
    this.height,
    this.minX,
    this.minY,
    this.defaultColor = Color.black,
  }) : _fields = List(height);

  void paint(int x, int y, Color color) {
    var row = _fields[y - minY];
    if (row == null) {
      row = List(width);
      _fields[y - minY] = row;
    }
    row[x - minX] = color;
  }

  Color get(int x, int y) {
    final row = _fields[y];
    if (row == null) return defaultColor;
    return row[x] ?? defaultColor;
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
          final color = row[x] ?? defaultColor;
          if (color == Color.white) {
            buffer.write('X');
          } else {
            buffer.write(' ');
          }
        }
      }
      buffer.writeln();
    }
    return buffer.toString();
  }
}
