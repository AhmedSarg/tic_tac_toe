import 'package:tic_tac_toe/logic_layer/play_history.dart';

import 'logic_ai.dart';
import 'logic_enums.dart';
import 'logic_extensions.dart';
import 'logic_funtions.dart';
import 'logic_grid.dart';
import 'logic_grid_analyzer.dart';
import 'logic_position.dart';

class XOGamePlay {
  final PersonMode _playerAMode;
  final PersonMode _playerBMode;

  final PlayerMode _playerAChoice;
  final PlayerMode _playerBChoice;

  final PlayHistory _history;

  final PlayGrid _grid;

  final List<GridPos> _winnerTiles;

  final void Function(XOGamePlay gamePlay) onGameEnd;

  bool _haltGame = false;
  GameStatus _status = GameStatus.ongoing;

  Player _currentPlayerRole = Player.playerA;

  XOGamePlay(
      this._playerAMode,
      this._playerBMode,
      this._playerAChoice,
      this._playerBChoice,
      this._grid,
      this.onGameEnd,
      this._winnerTiles,
      this._history);

  factory XOGamePlay.start({
    required PersonMode playerA,
    required PersonMode playerB,
    required PlayerMode playerAChoice,
    required void Function(XOGamePlay gamePlay) onGameEnd,
  }) {
    assert(playerAChoice != PlayerMode.naN);
    return XOGamePlay(
      playerA,
      playerB,
      playerAChoice,
      playerAChoice.opposite(),
      PlayGrid.createEmpty(),
      onGameEnd,
      List.empty(growable: true),
      PlayHistory(List.empty(growable: true)),
    );
  }

  bool setTile(int i, int j) {
    if (_haltGame) return false;

    bool isCurrentRoleHuman;
    PlayerMode currentChoice;

    switch (_currentPlayerRole) {
      case Player.playerA:
        isCurrentRoleHuman = (_playerAMode == PersonMode.human);
        currentChoice = _playerAChoice;
      case Player.playerB:
        isCurrentRoleHuman = (_playerBMode == PersonMode.human);
        currentChoice = _playerBChoice;
    }

    if (isCurrentRoleHuman && _grid.isTileEmpty(i, j)) {
      _grid.forceTile(i, j, currentChoice);
      _history.snapshotClone(_grid);
      _currentPlayerRole = _currentPlayerRole.opposite();
      return true;
    } else {
      return false;
    }
  }

  bool isWaitingHumanInput() {
    if (_haltGame) return false;

    bool isCurrentRoleHuman;

    switch (_currentPlayerRole) {
      case Player.playerA:
        isCurrentRoleHuman = (_playerAMode == PersonMode.human);
      case Player.playerB:
        isCurrentRoleHuman = (_playerBMode == PersonMode.human);
    }

    return isCurrentRoleHuman;
  }

  bool isGameStopped() => _haltGame;

  PlayerMode getTile(int i, int j) {
    assert(checkPosition(i, j));
    return _grid.getTile(i, j);
  }

  void update() {
    //check if game stopped
    _status = LogicGridAnalyzer.analyze(_grid, _winnerTiles);

    if (_status == GameStatus.ongoing) {
      //make the machine play
      bool isMachineRole;
      PersonMode currentMode;
      PlayerMode currentChoice;

      switch (_currentPlayerRole) {
        case Player.playerA:
          isMachineRole = (_playerAMode != PersonMode.human);
          currentMode = _playerAMode;
          currentChoice = _playerAChoice;
        case Player.playerB:
          isMachineRole = (_playerBMode != PersonMode.human);
          currentMode = _playerBMode;
          currentChoice = _playerBChoice;
      }

      if (isMachineRole) {
        GridPos movement = TicTacTocAI.suggest(
            mode: currentMode, grid: _grid, self: currentChoice);

        _grid.forceTile(movement.i, movement.j, currentChoice);
        _history.snapshotClone(_grid);
        _currentPlayerRole = _currentPlayerRole.opposite();

        //check again after ai play
        _status = LogicGridAnalyzer.analyze(_grid, _winnerTiles);
        if (_status != GameStatus.ongoing) {
          _haltGame = true;
          onGameEnd.call(this);
        }
      }
    } else {
      //game ended
      _haltGame = true;
      onGameEnd.call(this);
    }
  }

  GameStatus getGameStatus() => _status;

  PlayerMode getCurrentChoice() {
    switch (_currentPlayerRole) {
      case Player.playerA:
        return _playerAChoice;
      case Player.playerB:
        return _playerBChoice;
    }
  }

  List<GridPos> getWinnerTiles() => List.from(_winnerTiles);

  PlayHistory watchAIvsAI() {
    assert(
        _playerAMode != PersonMode.human && _playerBMode != PersonMode.human);

    while (isGameStopped() == false) {
      update();
    }

    return _history;
  }
}
