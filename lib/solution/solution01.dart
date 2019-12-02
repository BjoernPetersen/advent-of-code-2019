import 'package:advent/advent.dart';

class Solution1 extends Advent<int, int, int> {
  @override
  Future<int> solveOne() async {
    return input.map(_fuelForMass).fold<int>(0, (a, b) => a + b);
  }

  @override
  Future<int> solveTwo() async {
    return input
        .map(_fuelForMass)
        .map(_adjustedFuelMass)
        .fold<int>(0, (a, b) => a + b);
  }

  @override
  int readInputLine(String line) => int.parse(line);

  int _adjustedFuelMass(int fuelMass) {
    final additional = _fuelForMass(fuelMass);
    if (additional <= 0) {
      return fuelMass;
    } else {
      return fuelMass + _adjustedFuelMass(additional);
    }
  }

  int _fuelForMass(int mass) {
    return mass ~/ 3 - 2;
  }
}
