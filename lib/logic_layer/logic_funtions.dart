import 'dart:math';

import 'logic_constants.dart';

bool checkPosition(int i, j) {
  if (i < gridHeight && j < gridWidth) {
    return true;
  } else {
    return false;
  }
}

T getRandom<T>(List<T> items) {
  return items[Random.secure().nextInt(items.length)];
}
