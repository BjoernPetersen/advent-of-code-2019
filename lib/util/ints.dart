import 'dart:math';

extension IndexedInt on int {
  int operator [](int index) => digitAt(index);

  int digitAt(int index, {int length = 1}) {
    return (this % pow(10, index + 1 * length)) ~/ pow(10, index);
  }
}
