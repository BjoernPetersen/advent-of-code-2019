import 'dart:convert';
import 'dart:io';

import 'package:advent/solution/solutions.dart';
import 'package:args/args.dart';
import 'package:sprintf/sprintf.dart';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(
      "day",
      abbr: "d",
      help: "The day of the challenge. Option name can be ommitted.",
      valueHelp: "number",
    )
    ..addOption(
      "input",
      abbr: "i",
      help: "Input file, default to input/<day>.txt",
      valueHelp: "path to txt file",
    );

  final parsed = parser.parse(arguments);
  final code = await _run(parsed);

  if (code > 0) {
    print(parser.usage);
    exit(code);
  }
}

Future<int> _run(ArgResults args) async {
  final dayString = args["day"] ?? args.rest.first;
  if (dayString == null) {
    return 1;
  }

  final day = int.tryParse(dayString);
  if (day == null) {
    print("Not a number: $dayString");
    return 2;
  }

  final advent = await adventForDay(day);
  if (advent == null) {
    print("No implementation for day $day found");
    return 3;
  }

  final inputPath = args["input"] ?? sprintf("input/%02i.txt", [day]);
  final inputFile = File(inputPath);
  if (!await inputFile.exists()) {
    print("No such file: $inputPath");
    return 4;
  }
  final input = await inputFile.readAsString();
  advent.init(LineSplitter.split(input.trim()));

  final solutionOne = await advent.solveOne();
  print("Solution one: $solutionOne");

  final solutionTwo = await advent.solveTwo();
  print("Solution two: $solutionTwo");

  return 0;
}
