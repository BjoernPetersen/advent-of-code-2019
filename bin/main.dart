import 'dart:convert';
import 'dart:io';

import 'package:advent/solution/solutions.dart';
import 'package:args/args.dart';
import 'package:sprintf/sprintf.dart';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(
      'day',
      abbr: 'd',
      help: 'The day of the challenge. Option name can be ommitted.',
      valueHelp: 'number',
    )
    ..addOption(
      'input',
      abbr: 'i',
      help: 'Input file, default to input/<day>.txt',
      valueHelp: 'path to txt file',
    );

  final parsed = parser.parse(arguments);
  final code = await _run(parsed);

  if (code > 0) {
    print(parser.usage);
    exit(code);
  }
}

extension on ArgResults {
  String getDay() {
    final opt = this['day'];
    if (opt == null && rest.isNotEmpty) {
      return rest.first;
    } else {
      return opt;
    }
  }
}

Future<int> _run(ArgResults args) async {
  var dayString = args.getDay();
  if (dayString == null) {
    print('No day provided.');
    return 1;
  }

  final day = int.tryParse(dayString);
  if (day == null) {
    print('Not a number: $dayString');
    return 2;
  }

  final advent = await adventForDay(day);
  if (advent == null) {
    print('No implementation for day $day found');
    return 3;
  }

  final inputPath = args['input'] ?? sprintf('input/%02i.txt', [day]);
  final inputFile = File(inputPath);
  if (!await inputFile.exists()) {
    print('No such file: $inputPath');
    return 4;
  }
  final input = await inputFile.readAsString();
  advent.init(LineSplitter.split(input.trim()));

  final beforeOne = DateTime.now();
  final solutionOne = await advent.solveOne();
  final afterOne = DateTime.now();
  final durationOne = afterOne.difference(beforeOne);
  print('Solution one (${durationOne.inMilliseconds} ms): $solutionOne');

  final beforeTwo = DateTime.now();
  final solutionTwo = await advent.solveTwo();
  final afterTwo = DateTime.now();
  final durationTwo = afterTwo.difference(beforeTwo);
  print('Solution two (${durationTwo.inMilliseconds} ms): $solutionTwo');

  return 0;
}
