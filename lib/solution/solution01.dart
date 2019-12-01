import 'package:advent/advent.dart';

class Solution extends Advent {
  @override
  Future<String> solveOne() async {
    return input
        .map(int.parse)
        .map(_fuelForMass)
        .fold(0, (a, b) => a + b)
        .toString();
  }

  @override
  Future<String> solveTwo() async {
    return input
        .map(int.parse)
        .map(_fuelForMass)
        .map(_adjustedFuelMass)
        .fold(0, (a, b) => a + b)
        .toString();
  }

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
