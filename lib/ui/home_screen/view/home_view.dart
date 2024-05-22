import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ui/difficulty_screen/view/difficulty_screen.dart';

import '../../../logic/data_intent.dart';
import '../../../logic_layer/logic_enums.dart';
import '../../game_screen/view/game_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(
            'Tic Tac Toe',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const Spacer(flex: 2),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                  side: BorderSide(
                    color: Colors.black87,
                    width: 0,
                  ),
                ),
                builder: (context) => Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ChoiceButton(
                        text: 'Single Player',
                        gameMode: GameMode.single,
                      ),
                      ChoiceButton(
                        text: 'Play with a Friend',
                        gameMode: GameMode.friend,
                      ),
                      ChoiceButton(
                        text: 'Watch a Game',
                        gameMode: GameMode.watch,
                      ),
                    ],
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              // shape: const CircleBorder(),
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 50,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({
    super.key,
    required this.text,
    required this.gameMode,
  });

  final String text;
  final GameMode gameMode;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
        DataIntent.setGameMode = gameMode;
        Widget next;
        if (gameMode != GameMode.single) {
          next = const GameScreen();
        } else {
          next = const DifficultyScreen();
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => next,
          ),
        );
      },
      style: TextButton.styleFrom(
        shape: const LinearBorder(),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}