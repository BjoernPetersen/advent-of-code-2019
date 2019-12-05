extension Splitter on String {
  Iterable<String> splitOn(final int splitOn) sync* {
    for (var index = 0; index < this.length; ++index) {
      final codeUnit = this.codeUnitAt(index);
      if (codeUnit == splitOn) {
        yield this.substring(0, index);
        if (index != length - 1) {
          yield* this.substring(index + 1).splitOn(splitOn);
        }
        return;
      }
    }
    yield this;
  }
}
