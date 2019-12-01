abstract class Advent {
  List<String> _input;

  void init(List<String> input) {
    if (_input != null) {
      throw StateError("Can't set input twice");
    }
    this._input = input;
  }

  List<String> get input => _input;

  Future<String> solveOne();

  Future<String> solveTwo();
}
