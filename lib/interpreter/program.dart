import 'dart:collection';

class Program extends ListBase<int> {
  final List<int> _memory;
  int relativeBase = 0;

  @override
  int get length => _memory.length;

  Program(List<int> initialState)
      : _memory = List.of(initialState, growable: true);

  @override
  int operator [](int index) => index >= length ? 0 : _memory[index] ?? 0;

  @override
  void operator []=(int index, int value) {
    if (index >= length) {
      _memory.length = index + 1;
    }
    _memory[index] = value;
  }

  @override
  set length(int newLength) {
    throw UnsupportedError('Fixed length list');
  }
}
