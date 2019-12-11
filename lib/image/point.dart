class Point {
  final int x, y;

  const Point({
    this.x = 0,
    this.y = 0,
  });

  Point operator +(Point other) => Point(x: x + other.x, y: y + other.y);

  Point operator -(Point other) => Point(x: x - other.x, y: y - other.y);

  int distance(Point other) {
    return (x - other.x).abs() + (y - other.y).abs();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return '($x, $y)';
  }
}
