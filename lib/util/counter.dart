class Counter {
  static Map<T, int> count<T>(Iterable<T> values) {
    final result = <T, int>{};
    for (final value in values) {
      result.update(value, (old) => old + 1, ifAbsent: () => 1);
    }
    return result;
  }
}
