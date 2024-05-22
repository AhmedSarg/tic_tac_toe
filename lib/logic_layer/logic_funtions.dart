import 'logic_constants.dart';

bool checkPosition(int i, j) {
  if (i < gridHeight && j < gridWidth) {
    return true;
  } else {
    return false;
  }
}
