import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/ui/game_screen/viewmodel/game_states.dart';
import 'package:tic_tac_toe/ui/game_screen/viewmodel/game_viewmodel.dart';
import 'package:tic_tac_toe/ui/resources/app_colors.dart';
import 'package:tic_tac_toe/ui/resources/assets_manager.dart';

import '../../../logic_layer/logic_enums.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScoreBoard(),
            XOGridView(),
            GameActions(),
          ],
        ),
      ),
    );
  }
}

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScoreBoardItem(index: 0),
          ScoreBoardItem(index: 1),
        ],
      ),
    );
  }
}

class ScoreBoardItem extends StatelessWidget {
  const ScoreBoardItem({super.key, required this.index});

  final int index;

  final double height = 80.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameViewModel, GameStates>(
      builder: (context, state) {
        GameViewModel viewModel = GameViewModel.get(context);
        Color tileColor;
        if (index == 1 && viewModel.playerMode == PlayerMode.x) {
          tileColor = AppColors.playerXColor;
        } else if (index == 1 && viewModel.playerMode == PlayerMode.o) {
          tileColor = AppColors.playerOColor;
        } else if (index == 0 && viewModel.playerMode == PlayerMode.x) {
          tileColor = AppColors.playerOColor;
        } else {
          tileColor = AppColors.playerXColor;
        }
        String asset;
        if (index == 1 && viewModel.playerPersonMode == PersonMode.human) {
          asset = AssetsManager.personIcon;
        } else if (index == 1) {
          asset = AssetsManager.botIcon;
        } else if (viewModel.opponentPersonMode == PersonMode.human) {
          asset = AssetsManager.personIcon;
        } else {
          asset = AssetsManager.botIcon;
        }
        return Container(
          width: (MediaQuery.of(context).size.width - 60) / 2,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.transparent,
            borderRadius: BorderRadius.horizontal(
              right: index == 1
                  ? Radius.circular(height / 2)
                  : Radius.circular(height / 4),
              left: index == 0
                  ? Radius.circular(height / 2)
                  : Radius.circular(height / 4),
            ),
            border: Border.all(
              color: tileColor,
              width: 3,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: Directionality(
            textDirection: index == 0 ? TextDirection.ltr : TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: height / 2,
                  backgroundColor: tileColor,
                  child: Padding(
                    padding: EdgeInsets.all(height / 6),
                    child: SvgPicture.asset(
                      asset,
                      height: height,
                    ),
                  ),
                ),
                const Spacer(),
                FittedBox(
                  child: Text(
                    index == 0
                        ? viewModel.playerBScore.toString()
                        : viewModel.playerAScore.toString(),
                    style: TextStyle(
                      fontSize: height,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class XOGridView extends StatelessWidget {
  const XOGridView({super.key});

  final double spacing = 10.0;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
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
            itemCount: 9,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            itemBuilder: (context, index) {
              return XOGridItem(
                index: index,
                spacing: spacing,
              );
            },
          ),
        ),
      ),
    );
  }
}

class XOGridItem extends StatelessWidget {
  const XOGridItem({super.key, required this.index, required this.spacing});

  final int index;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameViewModel, GameStates>(
      builder: (context, state) {
        GameViewModel viewModel = GameViewModel.get(context);
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
                  ? const SizedBox()
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

class GameActions extends StatelessWidget {
  const GameActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: BlocBuilder<GameViewModel, GameStates>(
        builder: (context, state) {
          GameViewModel viewModel = GameViewModel.get(context);
          return viewModel.xoGamePlay.getGameStatus() == GameStatus.ongoing
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        viewModel.result,
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: viewModel.resultColor,
                                ),
                      ),
                    ),
                    Column(
                      children: [
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
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: viewModel.playAgain,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Play Again',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
        },
      ),
    );
  }
}
