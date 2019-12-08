import 'dart:async';

import 'package:async/async.dart';

abstract class IO {
  Future<int> read();

  void write(int value);
}

class StaticIO implements IO {
  final Iterator<int> _input;
  final List<int> output = [];

  StaticIO(List<int> input) : _input = input.iterator;

  @override
  Future<int> read() async {
    if (!_input.moveNext()) {
      throw StateError('no more input left');
    }
    return _input.current;
  }

  @override
  void write(int value) => output.add(value);
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
  void write(int value) {
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
  void write(int value) {
    _output.add(value);
  }

  void listen(void Function(int) onOutput) {
    _output.stream.listen((value) {
      lastOutput = value;
      onOutput(value);
    });
  }

  void addInput(int value) {
    _input.add(value);
  }
}
