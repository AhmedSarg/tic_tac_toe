import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/logic/data_intent.dart';
import 'package:tic_tac_toe/ui/choice_screen/viewmodel/choice_states.dart';

import '../../../logic_layer/logic_enums.dart';

class ChoiceViewModel extends Cubit<ChoiceStates> {
  ChoiceViewModel() : super(InitialState());

  static ChoiceViewModel get(context) => BlocProvider.of(context);

  PlayerMode? _choice;

  PlayerMode? get choice => _choice;

  set setChoice(PlayerMode choice) {
    _choice = choice;
    DataIntent.setPlayerMode = choice;
    emit(InitialState());
  }
}
