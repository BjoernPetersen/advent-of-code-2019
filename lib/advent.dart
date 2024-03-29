export 'package:advent/util/ints.dart';
export 'package:advent/util/strings.dart';

abstract class Advent<I, O1, O2> {
  List<I> _input;

  void init(Iterable<String> input) {
    if (_input != null) {
      throw StateError("Can't set input twice");
    }

    _input = input.map(readInputLine).toList();
  }

  List<I> get input => _input;

  I get single => input.single;

  I readInputLine(String line);

  Future<O1> solveOne();

  Future<O2> solveTwo();
}
