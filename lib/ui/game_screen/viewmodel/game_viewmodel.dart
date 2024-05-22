import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/logic/data_intent.dart';
import 'package:tic_tac_toe/ui/game_screen/viewmodel/game_states.dart';

import '../../../logic_layer/logic_enums.dart';

class GameViewModel extends Cubit<GameStates> {
  GameViewModel() : super(InitialState());

  static GameViewModel get(context) => BlocProvider.of(context);

  final List<String> _items = ['', '', '', '', '', '', '', '', ''];

  PlayerMode _playerMode = DataIntent.getPlayerMode;

  List<String> get items => _items;

  play(int index) {
    if (_items[index] == '') {
      _items[index] = _playerMode.name.toUpperCase();
      emit(PlayedState());
      togglePlayerMode();
    }
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
    emit(InitialState());
  }
}
