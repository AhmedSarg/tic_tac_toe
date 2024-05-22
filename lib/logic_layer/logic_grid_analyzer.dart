import 'logic_constants.dart';
import 'logic_enums.dart';
import 'logic_grid.dart';

class LogicGridAnalyzer {
  LogicGridAnalyzer._();

  static GameStatus analyze(PlayGrid grid) {
    Choice winner = Choice.naN;

    //todo return the tiles which make the player win
    //todo make code faster by skip the next loops when a player win

    //check horizontal
    for (int i = 0; i < gridHeight; i++) {
      if (grid.getTile(i, 0) == grid.getTile(i, 1) &&
          grid.getTile(i, 0) == grid.getTile(i, 2) &&
          grid.getTile(i, 0) != Choice.naN) {
        winner = grid.getTile(i, 0);
        break;
      }
    }

    //check vertical
    for (int j = 0; j < gridWidth; j++) {
      if (grid.getTile(0, j) == grid.getTile(1, j) &&
          grid.getTile(0, j) == grid.getTile(2, j) &&
          grid.getTile(0, j) != Choice.naN) {
        winner = grid.getTile(0, j);
        break;
      }
    }

    //check diagonal
    if (grid.getTile(0, 0) == grid.getTile(1, 1) &&
        grid.getTile(0, 0) == grid.getTile(2, 2) &&
        grid.getTile(0, 0) != Choice.naN) {
      winner = grid.getTile(0, 0);
    }

    //check reverse diagonal
    if (grid.getTile(0, 2) == grid.getTile(2, 0) &&
        grid.getTile(0, 2) == grid.getTile(1, 1) &&
        grid.getTile(0, 2) != Choice.naN) {
      winner = grid.getTile(0, 2);
    }

    //return the result
    switch (winner) {
      case Choice.x:
        return GameStatus.winX;
      case Choice.o:
        return GameStatus.winO;
      case Choice.naN:
        if (grid.isTotallyFilled()) {
          return GameStatus.draw;
        } else {
          return GameStatus.ongoing;
        }
    }
  }
}
