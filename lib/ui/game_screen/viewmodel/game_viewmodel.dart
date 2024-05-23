import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/logic_layer/data_intent.dart';
import 'package:tic_tac_toe/logic_layer/logic_constants.dart';
import 'package:tic_tac_toe/logic_layer/logic_extensions.dart';
import 'package:tic_tac_toe/logic_layer/logic_position.dart';
import 'package:tic_tac_toe/logic_layer/xo_gameplay.dart';
import 'package:tic_tac_toe/ui/game_screen/viewmodel/game_states.dart';
import 'package:tic_tac_toe/ui/resources/app_colors.dart';

import '../../../logic_layer/logic_enums.dart';

class GameViewModel extends Cubit<GameStates> {
  GameViewModel() : super(InitialState());

  static GameViewModel get(context) => BlocProvider.of(context);

  final List<String> _items = ['', '', '', '', '', '', '', '', ''];

  final List<int> _winningTiles = [];

  late XOGamePlay xoGamePlay;

  late PlayerMode _playerMode;

  late PersonMode _playerPersonMode;

  late PersonMode _opponentPersonMode;
  late Player _startPlayer;

  late GameMode _gameMode;

  late DifficultyLevel _difficultyLevel;

  late String _result = 'Initial';

  int _playerAScore = 0;
  int _playerBScore = 0;

  Color _resultColor = AppColors.gridLineColor;

  List<String> get items => _items;

  PlayerMode get playerMode => _playerMode;

  String get result => _result;

  Color get resultColor => _resultColor;

  List<int> get winningTiles => _winningTiles;

  int get playerAScore => _playerAScore;

  int get playerBScore => _playerBScore;

  PersonMode get playerPersonMode => _playerPersonMode;

  PersonMode get opponentPersonMode => _opponentPersonMode;

  set setResult(String result) {
    _result = result;
    emit(InitialState());
  }

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
    xoGamePlay.update();
    for (int ind = 0; ind < _items.length; ind++) {
      int i2 = vecToMat(ind).$1;
      int j2 = vecToMat(ind).$2;
      _items[ind] = xoGamePlay.getTile(i2, j2).symbol();
    }
    emit(PlayedState());
  }

  restart() {
    _items.fillRange(0, _items.length, '');
    _playerAScore = 0;
    _playerBScore = 0;
    start();
    emit(InitialState());
  }

  playAgain() {
    int a = _playerAScore;
    int b = _playerBScore;
    restart();
    _playerAScore = a;
    _playerBScore = b;
  }

  fetchGameOptions() {
    _playerMode = DataIntent.getPlayerMode;
    _startPlayer = DataIntent.getPlayerStart;
    _gameMode = DataIntent.getGameMode;
    _difficultyLevel = DataIntent.getDifficultyLevel;
    if (_gameMode == GameMode.single) {
      _playerPersonMode = PersonMode.human;
      if (_difficultyLevel == DifficultyLevel.easy) {
        _opponentPersonMode = PersonMode.machineRandom;
      } else if (_difficultyLevel == DifficultyLevel.medium) {
        _opponentPersonMode = PersonMode.machineIntermediate;
      } else {
        _opponentPersonMode = PersonMode.machineHard;
      }
    } else if (_gameMode == GameMode.friend) {
      _playerPersonMode = PersonMode.human;
      _opponentPersonMode = PersonMode.human;
    } else {
      _playerPersonMode = PersonMode.machineHard;
      _opponentPersonMode = PersonMode.machineHard;
    }
  }

  start() {
    fetchGameOptions();
    xoGamePlay = XOGamePlay.start(
      playerA: _playerPersonMode,
      playerB: _opponentPersonMode,
      playerAChoice: _playerMode,
      startPlayer: _startPlayer,
      onGameEnd: (gameplay) {
        _winningTiles.clear();
        for (GridPos tile in gameplay.getWinnerTiles()) {
          _winningTiles.add(matToVec(tile.i, tile.j));
        }
        if (gameplay.getGameStatus() != GameStatus.draw) {
          if (gameplay.getGameStatus().name[3] ==
              _playerMode.symbol().toUpperCase()) {
            _playerAScore++;
            if (DataIntent.getGameMode == GameMode.single) {
              _result = 'You Won';
              _resultColor = _playerMode == PlayerMode.x
                  ? AppColors.playerXColor
                  : AppColors.playerOColor;
              emit(WinState());
            } else {
              _result = 'Player A Wins';
              _resultColor = _playerMode == PlayerMode.x
                  ? AppColors.playerXColor
                  : AppColors.playerOColor;
              emit(PlayerAWins());
            }
          } else {
            _playerBScore++;
            if (DataIntent.getGameMode == GameMode.single) {
              _result = 'You Lost';
              _resultColor = _playerMode == PlayerMode.x
                  ? AppColors.playerOColor
                  : AppColors.playerXColor;
              emit(LoseState());
            } else {
              _result = 'Player B Wins';
              _resultColor = _playerMode == PlayerMode.x
                  ? AppColors.playerOColor
                  : AppColors.playerXColor;
              emit(PlayerBWins());
            }
          }
        } else if (gameplay.getGameStatus() == GameStatus.draw) {
          _result = 'Draw';
          _resultColor = AppColors.gridLineColor;
          emit(DrawState());
        }
        if (kDebugMode) {
          print('a score: $_playerAScore');
        }
        if (kDebugMode) {
          print('b score: $_playerBScore');
        }
      },
    );
    getComputerAnswer();
  }
}
