import 'dart:async';

import 'package:async/async.dart';

abstract class IO {
  Future<int> read();

  write(int value);
}

class StaticIO implements IO {
  final Iterator<int> _input;
  final List<int> output = List();

  StaticIO(List<int> input) : this._input = input.iterator;

  Future<int> read() async {
    if (!_input.moveNext()) {
      throw StateError("no more input left");
    }
    return _input.current;
  }

  write(int value) => output.add(value);
}

class WiredIO implements IO {
  final Future<int> Function() input;
  final Function(int) output;

  WiredIO({this.input, this.output});

  @override
  Future<int> read() {
    return input();
  }

  @override
  write(int value) {
    output(value);
  }
}

class StreamIO implements IO {
  final StreamController<int> _input = StreamController();
  StreamQueue<int> _inputStream;
  final StreamController<int> _output = StreamController();
  int lastOutput;

  StreamIO() {
    _inputStream = StreamQueue(_input.stream);
  }

  @override
  Future<int> read() => _inputStream.next;

  @override
  write(int value) {
    _output.add(value);
  }

  listen(void Function(int) onOutput) {
    _output.stream.listen((value) {
      this.lastOutput = value;
      onOutput(value);
    });
  }

  addInput(int value) {
    _input.add(value);
  }
}
