import 'logic_constants.dart';
import 'logic_enums.dart';
import 'logic_extensions.dart';
import 'logic_grid.dart';
import 'logic_grid_analyzer.dart';
import 'logic_position.dart';

class TicTacTocAI {
  TicTacTocAI._();

  static GridPos suggest({
    required PersonMode mode,
    required PlayGrid grid,
    required PlayerMode self,
  }) {
    List<GridPos> available = _getAvailableMovements(grid);
    int modeLvl = mode.getLevelNum();
    GridPos? result;

    //check if self win
    //random n    intermediate y       hard y
    if (modeLvl >= PersonMode.machineIntermediate.getLevelNum()) {
      result ??= _checkIfSelfWin(grid.clone(), self, List.of(available));
    }

    //check if another lose
    //random n    intermediate y       hard y
    if (modeLvl >= PersonMode.machineIntermediate.getLevelNum()) {
      result ??=
          _checkIfSelfWin(grid.clone(), self.opposite(), List.of(available));
    }

    //try not to let opponent to make two ways to win
    //random n    intermediate n       hard y
    if (modeLvl >= PersonMode.machineHard.getLevelNum()) {
      result ??=
          _get2WaysToSelfWin(grid.clone(), self.opposite(), List.of(available));
    }

    //try to open two ways against opponent
    //random n    intermediate n       hard y
    if (modeLvl >= PersonMode.machineHard.getLevelNum()) {
      result ??= _get2WaysToSelfWin(grid.clone(), self, List.of(available));
    }

    //random movement
    //random y    intermediate y       hard y
    result ??= available.first;

    return result;
  }

  static List<GridPos> _getAvailableMovements(PlayGrid grid) {
    List<GridPos> available = [];

    for (int i = 0; i < gridHeight; i++) {
      for (int j = 0; j < gridWidth; j++) {
        if (grid.isTileEmpty(i, j)) {
          available.add(GridPos(i, j));
        }
      }
    }

    return available..shuffle();
    // return available;
  }

  static GridPos? _checkIfSelfWin(
      PlayGrid grid, PlayerMode self, List<GridPos> available) {
    for (int i = 0; i < available.length; i++) {
      GridPos pos = available[i];
      grid.forceTile(pos.i, pos.j, self);
      if (i > 0) {
        grid.forceTile(
          available[i - 1].i,
          available[i - 1].j,
          PlayerMode.naN,
        );
      }

      GameStatus analysis = LogicGridAnalyzer.analyze(grid);
      switch (analysis) {
        case GameStatus.winX:
          if (self == PlayerMode.x) return pos;
        case GameStatus.winO:
          if (self == PlayerMode.o) return pos;
        default:
          continue;
      }
    }

    return null;
  }

  static GridPos? _get2WaysToSelfWin(
      PlayGrid grid, PlayerMode self, List<GridPos> available) {
    for (int i = 0; i < available.length; i++) {
      PlayGrid gridClone = grid.clone();

      GridPos posI = available[i];
      GridPos? pos1, pos2;

      gridClone.forceTile(posI.i, posI.j, self);
      // print("Test grid");
      // gridClone.displayToConsole();
      //check way 1
      pos1 = _checkIfSelfWin(
        gridClone.clone(),
        self,
        List.from(available)..removeAt(i),
      );
      if (pos1 != null) {
        //check way 2
        pos2 = _checkIfSelfWin(
          gridClone.clone(),
          self,
          List.from(available)
            ..removeAt(i)
            ..remove(pos1),
        );
      }

      // print("""
      // Test: posi: ${posI}
      //       p1 :  ${pos1}
      //       p2 :  ${pos2}
      //
      // """);
      if (pos1 != null && pos2 != null) {
        return available[i];
        // print("---> ${posI}<---");
      }
    }
    return null;
  }
}