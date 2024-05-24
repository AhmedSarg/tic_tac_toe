import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/logic_layer/data_intent.dart';
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
          SizedBox(
            width: 20,
            child: Center(
              child: FittedBox(
                child: Text('VS'),
              ),
            ),
          ),
          ScoreBoardItem(index: 1),
        ],
      ),
    );
  }
}

class ScoreBoardItem extends StatelessWidget {
  const ScoreBoardItem({super.key, required this.index});

  final int index;

  final double height = 60.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameViewModel, GameStates>(
      builder: (context, state) {
        GameViewModel viewModel = GameViewModel.get(context);
        Color tileColor;
        PlayerMode tilePlayerMode;
        if (index == 1 && viewModel.playerMode == PlayerMode.x) {
          tileColor = AppColors.playerXColor;
          tilePlayerMode = PlayerMode.x;
        } else if (index == 1 && viewModel.playerMode == PlayerMode.o) {
          tileColor = AppColors.playerOColor;
          tilePlayerMode = PlayerMode.o;
        } else if (index == 0 && viewModel.playerMode == PlayerMode.x) {
          tileColor = AppColors.playerOColor;
          tilePlayerMode = PlayerMode.o;
        } else {
          tileColor = AppColors.playerXColor;
          tilePlayerMode = PlayerMode.x;
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
        String tileText;
        if (viewModel.playerPersonMode == PersonMode.human &&
            viewModel.opponentPersonMode == PersonMode.human) {
          // Human vs Human
          tileText = index == 1
              ? DataIntent.getPlayerAName ?? 'Human'
              : DataIntent.getPlayerBName ?? 'Human';
        } else if (viewModel.playerPersonMode != PersonMode.human) {
          //Bot vs Bot
          tileText = 'Bot ${1 - index + 1}';
        } else {
          //Human vs Bot
          if (index == 0) {
            //left tile (bot tile)
            tileText = 'Bot';
          } else {
            //right tile (your tile)
            tileText = 'You';
          }
        }
        return Directionality(
          textDirection: index == 0 ? TextDirection.ltr : TextDirection.rtl,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: viewModel.xoGamePlay.getCurrentChoice() == tilePlayerMode
                    ? 0
                    : -100,
                right: viewModel.xoGamePlay.getCurrentChoice() == tilePlayerMode
                    ? 0
                    : -100,
                child: SizedBox(
                  width: (MediaQuery.of(context).size.width - 80) / 2,
                  child: const Text(
                    'Your Turn',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: height / 4),
                    child: Text(
                      tileText,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: (MediaQuery.of(context).size.width - 80) / 2,
                    height: height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
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
                        ).animate(
                          onPlay: (anim) {
                            anim.repeat();
                          },
                          effects: viewModel.xoGamePlay.getCurrentChoice() ==
                                  tilePlayerMode
                              ? [
                                  const ShimmerEffect(
                                    delay: Duration(milliseconds: 300),
                                    duration: Duration(seconds: 1),
                                    size: 1,
                                    padding: 0,
                                  ),
                                ]
                              : [
                                  CustomEffect(
                                    builder: (context, value, child) {
                                      return child;
                                    },
                                  ),
                                ],
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
                ],
              ),
            ],
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
          return FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    viewModel.xoGamePlay.getGameStatus() == GameStatus.ongoing
                        ? ' '
                        : viewModel.result,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: viewModel.resultColor,
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: viewModel.xoGamePlay.getGameStatus() ==
                              GameStatus.ongoing
                          ? null
                          : ElevatedButton(
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
                        onPressed: viewModel.xoGamePlay.getGameStatus() ==
                                GameStatus.ongoing
                            ? viewModel.restart
                            : viewModel.playAgain,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          viewModel.xoGamePlay.getGameStatus() ==
                                  GameStatus.ongoing
                              ? 'Restart'
                              : 'Play Again',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
