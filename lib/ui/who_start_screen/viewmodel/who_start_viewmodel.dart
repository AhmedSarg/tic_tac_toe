import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/logic_layer/data_intent.dart';
import 'package:tic_tac_toe/ui/who_start_screen/viewmodel/who_start_states.dart';

import '../../../logic_layer/logic_enums.dart';

class WhoStartViewModel extends Cubit<WhoStartStates> {
  WhoStartViewModel() : super(InitialState());

  static WhoStartViewModel get(context) => BlocProvider.of(context);

  Player? _startPlayer;

  Player? get startPlayer => _startPlayer;

  set setWhoStart(Player startPlayer) {
    _startPlayer = startPlayer;
    DataIntent.setPlayerStart = startPlayer;
    emit(InitialState());
  }
}
