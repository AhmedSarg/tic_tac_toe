import 'logic_enums.dart';

class DataIntent {
  static GameMode? _gameMode;

  static set setGameMode(GameMode gameMode) => _gameMode = gameMode;

  static GameMode get getGameMode => _gameMode!;

  //--------------------------------------------------------------------------

  static PlayerMode? _playerMode;

  static set setPlayerMode(PlayerMode playerMode) => _playerMode = playerMode;

  static PlayerMode get getPlayerMode => _playerMode ?? PlayerMode.x;

  //--------------------------------------------------------------------------

  static DifficultyLevel? _difficultyLevel;

  static set setDifficultyLevel(DifficultyLevel difficultyLevel) {
    _difficultyLevel = difficultyLevel;
    print('difficulty level set to $_difficultyLevel');
  }

  static DifficultyLevel get getDifficultyLevel => _difficultyLevel!;
}
