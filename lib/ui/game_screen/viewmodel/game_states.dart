import 'dart:ui';

abstract class GameStates {}

class InitialState extends GameStates {}

class PlayedState extends GameStates {}

class WinState extends GameStates {}

class LoseState extends GameStates {}

class DrawState extends GameStates {}

class PlayerAWins extends GameStates {}

class PlayerBWins extends GameStates {}

class ResultState extends GameStates {
  final String result;
  final Color color;

  ResultState({
    required this.result,
    required this.color,
  });
}
