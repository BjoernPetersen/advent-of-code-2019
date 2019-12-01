import 'package:advent/input.dart';
import 'package:advent/solution/solutions.dart';

Future<int> main(List<String> arguments) async {
  if (arguments.length != 1) {
    print("Need exactly one integer argument");
    return 1;
  }
  final day = int.tryParse(arguments.first);
  if (day == null) {
    print("Not a number: ${arguments.first}");
    return 2;
  }

  final advent = await adventForDay(day);
  if (advent == null) {
    print("No implementation for day $day found");
    return 3;
  }

  final input = await getInput(day);
  advent.init(input);

  final solutionOne = await advent.solveOne();
  print("Solution one: $solutionOne");

  final solutionTwo = await advent.solveTwo();
  print("Solution two: $solutionTwo");

  return 0;
}
