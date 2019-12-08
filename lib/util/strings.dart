extension Splitter on String {
  Iterable<String> splitOn(final int splitOn) sync* {
    for (var index = 0; index < length; ++index) {
      final codeUnit = codeUnitAt(index);
      if (codeUnit == splitOn) {
        yield substring(0, index);
        if (index != length - 1) {
          yield* substring(index + 1).splitOn(splitOn);
        }
        return;
      }
    }
    yield this;
  }
}
