import 'dart:io';

import 'logic_constants.dart';
import 'logic_enums.dart';
import 'logic_extensions.dart';
import 'logic_funtions.dart';

class PlayGrid {
  final List<List<Choice>> _grid;

  PlayGrid(this._grid);

  PlayGrid.createEmpty()
      : _grid = List.generate(
            gridHeight, (i) => List.filled(gridWidth, Choice.naN));

  PlayGrid clone() {
    List<List<Choice>> cloneData = List.generate(
        gridHeight, (i) => List.filled(gridWidth, Choice.naN));

    for (int i = 0; i < gridHeight; i++) {
      for (int j = 0; j < gridWidth; j++) {
        cloneData[i][j] = _grid[i][j];
      }
    }

    return PlayGrid(cloneData);
  }

  Choice getTile(int i, int j) {
    if (checkPosition(i, j)) return _grid[i][j];
    return Choice.naN;
  }

  void forceTile(int i, int j, Choice choice) {
    if (checkPosition(i, j)) _grid[i][j] = choice;
  }

  bool isTileEmpty(int i, int j) {
    if (checkPosition(i, j)) {
      return (_grid[i][j] == Choice.naN);
    }
    return false;
  }

  void displayToConsole() {
    stdout.write("\n \t\tPlayGrid 3*3\t\t\n\n");
    for (int i = 0; i < gridHeight; i++) {
      for (int j = 0; j < gridWidth; j++) {
        stdout.write(_grid[i][j].symbol());
        stdout.write(" ");
      }
      stdout.write("\n");
    }
  }

  bool isTotallyFilled() {
    for (int i = 0; i < gridHeight; i++) {
      for (int j = 0; j < gridWidth; j++) {
        if (_grid[i][j] == Choice.naN) return false;
      }
    }
    return true;
  }
}
