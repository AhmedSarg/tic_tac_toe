import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/logic_layer/data_intent.dart';
import 'package:tic_tac_toe/logic_layer/logic_constants.dart';
import 'package:tic_tac_toe/logic_layer/logic_extensions.dart';
import 'package:tic_tac_toe/logic_layer/xo_gameplay.dart';
import 'package:tic_tac_toe/ui/game_screen/viewmodel/game_states.dart';

import '../../../logic_layer/logic_enums.dart';

class GameViewModel extends Cubit<GameStates> {
  GameViewModel() : super(InitialState());

  static GameViewModel get(context) => BlocProvider.of(context);

  final List<String> _items = ['', '', '', '', '', '', '', '', ''];

  late XOGamePlay xoGamePlay;

  PlayerMode _playerMode = DataIntent.getPlayerMode;

  List<String> get items => _items;

  int matToVec(int i, int j) {
    return i * gridWidth + j;
  }

  (int, int) vecToMat(int i) {
    return (i ~/ gridWidth, i % gridWidth);
  }

  play(int index) {
    if (_items[index] == '') {
      int i1 = vecToMat(index).$1;
      int j1 = vecToMat(index).$2;
      xoGamePlay.setTile(i1, j1);
      _items[index] = xoGamePlay.getTile(i1, j1).symbol();
      xoGamePlay.update();
      Future.delayed(
        const Duration(seconds: 1),
        () {
          getComputerAnswer();
        },
      );
      emit(PlayedState());
    }
  }

  getComputerAnswer() {
    for (int ind = 0; ind < _items.length; ind++) {
      int i2 = vecToMat(ind).$1;
      int j2 = vecToMat(ind).$2;
      _items[ind] = xoGamePlay.getTile(i2, j2).symbol();
    }
    emit(PlayedState());
  }

  togglePlayerMode() {
    if (_playerMode == PlayerMode.x) {
      _playerMode = PlayerMode.o;
    } else {
      _playerMode = PlayerMode.x;
    }
  }

  restart() {
    _items.fillRange(0, _items.length, '');
    _playerMode = DataIntent.getPlayerMode;
    start();
    emit(InitialState());
  }

  start() {
    PersonMode opponentMode;
    if (DataIntent.getGameMode != GameMode.single) {
      opponentMode = PersonMode.human;
    } else if (DataIntent.getDifficultyLevel == DifficultyLevel.easy) {
      opponentMode = PersonMode.machineRandom;
    } else if (DataIntent.getDifficultyLevel == DifficultyLevel.medium) {
      opponentMode = PersonMode.machineIntermediate;
    } else {
      opponentMode = PersonMode.machineHard;
    }
    PlayerMode opponentChoice;
    if (DataIntent.getPlayerMode == PlayerMode.x) {
      opponentChoice = PlayerMode.o;
    } else {
      opponentChoice = PlayerMode.x;
    }
    xoGamePlay = XOGamePlay.start(
      playerA: PersonMode.human,
      playerB: opponentMode,
      playerAChoice: _playerMode,
      onGameEnd: (gameplay) {
        if (gameplay.getGameStatus() != GameStatus.ongoing &&
            gameplay.getGameStatus() != GameStatus.draw) {
          if (gameplay.getGameStatus().name[3] ==
              _playerMode.symbol().toUpperCase()) {
            emit(
              DataIntent.getGameMode == GameMode.single
                  ? WinState()
                  : PlayedState(),
            );
          } else {
            emit(
              DataIntent.getGameMode == GameMode.single
                  ? LoseState()
                  : PlayerBWins(),
            );
          }
        } else if (gameplay.getGameStatus() == GameStatus.draw) {
          emit(DrawState());
        }
      },
    );
  }
}
