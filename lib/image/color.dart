enum Color {
  black,
  white,
  transparent,
}

Color color(int code) {
  return Color.values[code];
}
