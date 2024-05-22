import 'logic_constants.dart';
import 'logic_enums.dart';
import 'logic_grid.dart';
import 'logic_position.dart';

class LogicGridAnalyzer {
  LogicGridAnalyzer._();

  static GameStatus analyze(PlayGrid grid, List<GridPos> winTiles) {
    PlayerMode winner = PlayerMode.naN;
    winTiles.clear();

    //todo return the tiles which make the player win
    //todo make code faster by skip the next loops when a player win

    //check horizontal
    for (int i = 0; i < gridHeight; i++) {
      if (grid.getTile(i, 0) == grid.getTile(i, 1) &&
          grid.getTile(i, 0) == grid.getTile(i, 2) &&
          grid.getTile(i, 0) != PlayerMode.naN) {
        winner = grid.getTile(i, 0);
        winTiles.addAll([
          GridPos(i, 0),
          GridPos(i, 1),
          GridPos(i, 2),
        ]);
        break;
      }
    }

    //check vertical
    for (int j = 0; j < gridWidth; j++) {
      if (grid.getTile(0, j) == grid.getTile(1, j) &&
          grid.getTile(0, j) == grid.getTile(2, j) &&
          grid.getTile(0, j) != PlayerMode.naN) {
        winner = grid.getTile(0, j);
        winTiles.addAll([
          GridPos(0, j),
          GridPos(1, j),
          GridPos(2, j),
        ]);
        break;
      }
    }

    //check diagonal
    if (grid.getTile(0, 0) == grid.getTile(1, 1) &&
        grid.getTile(0, 0) == grid.getTile(2, 2) &&
        grid.getTile(0, 0) != PlayerMode.naN) {
      winner = grid.getTile(0, 0);
      winTiles.addAll([
        GridPos(0, 0),
        GridPos(1, 1),
        GridPos(2, 2),
      ]);
    }

    //check reverse diagonal
    if (grid.getTile(0, 2) == grid.getTile(2, 0) &&
        grid.getTile(0, 2) == grid.getTile(1, 1) &&
        grid.getTile(0, 2) != PlayerMode.naN) {
      winner = grid.getTile(0, 2);
      winTiles.addAll([
        GridPos(0, 2),
        GridPos(1, 1),
        GridPos(2, 0),
      ]);
    }

    //return the result
    switch (winner) {
      case PlayerMode.x:
        return GameStatus.winX;
      case PlayerMode.o:
        return GameStatus.winO;
      case PlayerMode.naN:
        if (grid.isTotallyFilled()) {
          return GameStatus.draw;
        } else {
          return GameStatus.ongoing;
        }
    }
  }
}
