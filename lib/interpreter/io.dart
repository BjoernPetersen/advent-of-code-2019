class IO {
  final Iterator<int> _input;
  final List<int> output = List();

  IO(List<int> input) : this._input = input.iterator;

  int read() {
    if (!_input.moveNext()) {
      throw StateError("no more input left");
    }
    return _input.current;
  }

  write(int value) => output.add(value);
}
