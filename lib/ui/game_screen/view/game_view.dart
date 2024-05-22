import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/ui/game_screen/viewmodel/game_states.dart';
import 'package:tic_tac_toe/ui/game_screen/viewmodel/game_viewmodel.dart';
import 'package:tic_tac_toe/ui/resources/assets_manager.dart';

import '../../../logic_layer/logic_enums.dart';
import '../../resources/app_colors.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 30),
            const Flexible(
              child: AspectRatio(
                aspectRatio: 1,
                child: XOGridView(),
              ),
            ),
            BlocBuilder<GameViewModel, GameStates>(
              builder: (context, state) {
                GameViewModel viewModel = GameViewModel.get(context);
                return SizedBox(
                  height: 210,
                  child: viewModel.xoGamePlay.getGameStatus() ==
                          GameStatus.ongoing
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: const EdgeInsets.only(top: 50),
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
                        )
                      : Column(
                          children: [
                            FittedBox(
                              child: Text(
                                viewModel.result,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                      color: viewModel.resultColor,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                                  'Play Again',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'Main Menu',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),
          ],
        ),
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
            physics: const NeverScrollableScrollPhysics(),
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
                    child: viewModel.items[index] == ''
                        ? Text(
                            viewModel.items[index],
                            style: TextStyle(
                              fontFamily: GoogleFonts.gabarito().fontFamily,
                              color: viewModel.items[index].toLowerCase() ==
                                      PlayerMode.x.name
                                  ? AppColors.playerXColor
                                  : AppColors.playerOColor,
                            ),
                          )
                        : viewModel.items[index] == 'X'
                            ? Lottie.asset(
                                AssetsManager.xLottie,
                                repeat: false,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(100.0),
                                child: Lottie.asset(
                                  AssetsManager.oLottie,
                                  repeat: false,
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
