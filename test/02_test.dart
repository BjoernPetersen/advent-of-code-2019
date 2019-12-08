import 'package:advent/interpreter/interpreter.dart';
import 'package:advent/util/strings.dart';
import 'package:test/test.dart';

Future<int> _run(String input) async {
  final program =
      input.splitOn(','.codeUnitAt(0)).map(int.parse).toList(growable: false);
  return await Interpreter().execute(program);
}

Future main() async {
  group('part one', () {
    test('test',
        () => expect(_run('1,9,10,3,2,3,11,0,99,30,40,50'), completion(3500)));
  });
}
