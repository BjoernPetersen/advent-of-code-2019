import 'dart:math';

import 'package:advent/advent.dart';

class Solution6 extends Advent<void, int, int> {
  final Map<String, OrbitObject> objectByName = Map();

  @override
  void readInputLine(String line) {
    final parts = line.split(")");
    final orbited = parts[0];
    objectByName[parts[1]] = OrbitObject(parts[1], orbited);
  }

  @override
  void init(Iterable<String> input) {
    objectByName["COM"] = OrbitObject("COM", null);
    super.init(input);
    for (final object in objectByName.values) {
      object.init((name) => objectByName[name]);
    }
  }

  @override
  Future<int> solveOne() async {
    final Map<OrbitObject, int> counts = Map();
    for (final object in objectByName.values) {
      _addCount(counts, object);
    }
    return counts.values.reduce((a, b) => a + b);
  }

  int _addCount(Map<OrbitObject, int> counts, OrbitObject object) {
    final existingCount = counts[object];
    if (existingCount != null) {
      return existingCount;
    }

    final orbited = object.orbited;
    if (orbited == null) {
      final result = 0;
      counts[object] = result;
      return result;
    } else {
      final result = 1 + _addCount(counts, orbited);
      counts[object] = result;
      return result;
    }
  }

  @override
  Future<int> solveTwo() async {
    final start = objectByName["YOU"].orbited;
    final end = objectByName["SAN"].orbited;
    final result = _minimumDist(start, end, Map());
    return result;
  }

  int _minimumDist(
    OrbitObject start,
    OrbitObject end,
    Map<OrbitObject, int> distance,
  ) {
    if (start == end) return 0;
    final existing = distance[start];
    if (existing != null) return existing;
    distance[start] = 999999;

    Iterable<int> possible() sync* {
      if (start.orbited != null) {
        yield _minimumDist(start.orbited, end, distance);
      }
      yield* start.orbiters.map((obj) => _minimumDist(obj, end, distance));
    }

    final result = 1 + possible().reduce(min);
    distance[start] = result;
    return result;
  }
}

class OrbitObject {
  final String name;
  final String _orbited;
  final Set<OrbitObject> orbiters;

  OrbitObject _orbitedObject;

  OrbitObject get orbited => _orbitedObject;

  OrbitObject(this.name, String orbited)
      : this.orbiters = Set(),
        this._orbited = orbited;

  init(OrbitObject Function(String) getObject) {
    if (_orbited != null) {
      _orbitedObject = getObject(_orbited);
      _orbitedObject.orbiters.add(this);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrbitObject &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}
