import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/ui/game_screen/view/game_view.dart';
import 'package:tic_tac_toe/ui/game_screen/viewmodel/game_states.dart';
import 'package:tic_tac_toe/ui/game_screen/viewmodel/game_viewmodel.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GameViewModel(),
        child: BlocConsumer<GameViewModel, GameStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return buildContent();
          },
        ),
      ),
    );
  }

  Widget buildContent() {
    return const GameView();
  }
}
