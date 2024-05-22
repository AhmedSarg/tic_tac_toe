import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/logic_layer/data_intent.dart';
import 'package:tic_tac_toe/ui/difficulty_screen/viewmodel/difficulty_states.dart';

import '../../../logic_layer/logic_enums.dart';

class DifficultyViewModel extends Cubit<DifficultyStates> {
  DifficultyViewModel() : super(InitialState());

  static DifficultyViewModel get(context) => BlocProvider.of(context);

  start() {
    DataIntent.setDifficultyLevel = DifficultyLevel.easy;
  }

  final CarouselController _carouselController = CarouselController();

  CarouselController get carouselController => _carouselController;
}
