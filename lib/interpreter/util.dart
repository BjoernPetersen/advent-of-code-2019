import 'package:advent/util/strings.dart';

List<int> readProgramLine(String line) {
  return line.splitOn(','.codeUnitAt(0)).map(int.parse).toList(growable: false);
}
