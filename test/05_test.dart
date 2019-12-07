import 'package:advent/interpreter/interpreter.dart';
import 'package:advent/interpreter/io.dart';
import 'package:advent/util/strings.dart';
import 'package:test/test.dart';

Future<int> _advent(String programStr, int input) async {
  final program = programStr
      .splitOn(",".codeUnitAt(0))
      .map(int.parse)
      .toList(growable: false);
  final interpreter = Interpreter();
  final io = StaticIO([input]);
  await interpreter.execute(program, io: io);
  return io.output.last;
}

Future main() async {
  test("equal 8",
      () => expect(_advent("3,9,8,9,10,9,4,9,99,-1,8", 8), completion(1)));
  test("not equal 8",
      () => expect(_advent("3,9,8,9,10,9,4,9,99,-1,8", 6), completion(0)));
  test("immediate equal 8",
      () => expect(_advent("3,3,1108,-1,8,3,4,3,99", 8), completion(1)));
  test("immediate not equal 8",
      () => expect(_advent("3,3,1108,-1,8,3,4,3,99", 9), completion(0)));

  test(
      "juming zero",
      () => expect(
            _advent("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", 2),
            completion(1),
          ));
  test(
      "jumping nonzero",
      () => expect(
            _advent("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", 0),
            completion(0),
          ));

  test(
      "8 comparison equal",
      () => expect(
            _advent(
              "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99",
              8,
            ),
            completion(1000),
          ));
  test(
      "8 comparison less",
      () => expect(
            _advent(
              "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99",
              7,
            ),
            completion(999),
          ));
  test(
      "8 comparison greater",
      () => expect(
            _advent(
              "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99",
              9,
            ),
            completion(1001),
          ));
}
