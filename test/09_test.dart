import 'package:advent/interpreter/interpreter.dart';
import 'package:advent/interpreter/io.dart';
import 'package:test/test.dart';

Future<List<int>> interpret(List<int> program, [List<int> input]) async {
  final io = StaticIO(input ?? []);
  await Interpreter().execute(program, io: io);
  return io.output;
}

Future<void> main() async {
  final ex1 =
      '109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99'.toProgram();
  test('ex1', () => expect(interpret(ex1), completion(ex1)));

  final ex2 = '1102,34915192,34915192,7,4,7,99,0'.toProgram();
  test(
    'ex2',
    () => expect(
        interpret(ex2), completion((it) => it.single.toString().length == 16)),
  );

  final ex3 = '104,1125899906842624,99'.toProgram();
  test('ex3', () => expect(interpret(ex3), completion([1125899906842624])));
}

extension on String {
  List<int> toProgram() {
    return split(',').map(int.parse).toList(growable: false);
  }
}
