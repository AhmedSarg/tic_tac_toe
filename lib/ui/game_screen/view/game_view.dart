import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/ui/game_screen/viewmodel/game_states.dart';
import 'package:tic_tac_toe/ui/game_screen/viewmodel/game_viewmodel.dart';
import 'package:tic_tac_toe/ui/resources/app_colors.dart';

import '../../../logic_layer/logic_enums.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  static late GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = GameViewModel.get(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Spacer(),
          const XOGridView(),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
              onPressed: viewModel.restart,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Restart',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class XOGridView extends StatelessWidget {
  const XOGridView({super.key});
  final double spacing = 10.0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameViewModel, GameStates>(
      builder: (context, state) {
        GameViewModel viewModel = GameViewModel.get(context);
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            shrinkWrap: true,
            itemCount: viewModel.items.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  viewModel.play(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: getTileBorderRadius(index, spacing),
                  ),
                  child: FittedBox(
                    child: Text(
                      viewModel.items[index],
                      style: TextStyle(
                        fontFamily: GoogleFonts.gabarito().fontFamily,
                        color: viewModel.items[index].toLowerCase() ==
                                PlayerMode.x.name
                            ? AppColors.playerXColor
                            : AppColors.playerOColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  BorderRadius getTileBorderRadius(int index, double radius) {
    switch (index) {
      case 0:
        return BorderRadius.only(
          bottomRight: Radius.circular(radius),
        );
      case 1:
        return BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      case 2:
        return BorderRadius.only(
          bottomLeft: Radius.circular(radius),
        );
      case 3:
        return BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      case 5:
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        );
      case 6:
        return BorderRadius.only(
          topRight: Radius.circular(radius),
        );
      case 7:
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        );
      case 8:
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
        );
      default:
        return BorderRadius.all(Radius.circular(radius));
    }
  }
}
