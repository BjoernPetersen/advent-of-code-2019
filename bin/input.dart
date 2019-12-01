import 'dart:convert';

import 'package:resource/resource.dart';
import 'package:sprintf/sprintf.dart';

Future<List<String>> getInput(int day) async {
  final name = sprintf("input/%02i.txt", [day]);
  final res = Resource(name);
  final input = await res.readAsString(encoding: utf8);
  return input?.trim()?.split("\n");
}
