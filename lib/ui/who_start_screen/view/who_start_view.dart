import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/logic_layer/logic_extensions.dart';
import 'package:tic_tac_toe/ui/game_screen/view/game_screen.dart';
import 'package:tic_tac_toe/ui/resources/app_colors.dart';

import '../../../logic_layer/logic_enums.dart';
import '../viewmodel/who_start_states.dart';
import '../viewmodel/who_start_viewmodel.dart';

class WhoStartView extends StatelessWidget {
  const WhoStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(flex: 1),
          const Text(
            'Who Will Start?',
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 2),
          const WhoStartsRow(),
          const Spacer(flex: 2),
          BlocBuilder<WhoStartViewModel, WhoStartStates>(
            builder: (context, state) {
              WhoStartViewModel viewModel = WhoStartViewModel.get(context);
              return SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: viewModel.startPlayer != null
                      ? () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GameScreen(),
                            ),
                            (r) => r.isFirst,
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                  ),
                  child: Text(
                    'Start the Game',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              );
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class WhoStartsRow extends StatelessWidget {
  const WhoStartsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Spacer(),
        WhoStart(player: Player.playerA),
        Spacer(),
        WhoStart(player: Player.playerB),
        Spacer(),
      ],
    );
  }
}

class WhoStart extends StatelessWidget {
  const WhoStart({
    super.key,
    required this.player,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WhoStartViewModel, WhoStartStates>(
      builder: (context, state) {
        WhoStartViewModel viewModel = WhoStartViewModel.get(context);
        Color color = player == Player.playerA
            ? AppColors.playerXColor
            : AppColors.playerOColor;
        bool chosen = viewModel.startPlayer == player;
        bool initial = viewModel.startPlayer == null;
        double width = MediaQuery.of(context).size.width * 5 / 13;
        if (chosen && !initial) {
          width = MediaQuery.of(context).size.width * 6 / 13;
        } else if (!chosen && !initial) {
          width = MediaQuery.of(context).size.width * 4 / 13;
        }
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: width,
          height: MediaQuery.of(context).size.height * .4,
          child: Opacity(
            opacity: chosen || initial ? 1 : .3,
            child: TextButton(
              onPressed: () {
                viewModel.setWhoStart = player;
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: color),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: (MediaQuery.of(context).size.height * .4 - 60) * .7,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          player.toStrAsSingleMode().toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                            color: color,
                            shadows: [
                              BoxShadow(
                                color: color.withOpacity(.4),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height * .4 - 60) * .3,
                    child: Center(
                      child: Dot(
                        selected: viewModel.startPlayer == player,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({
    super.key,
    required this.selected,
    required this.color,
  });

  final double size = 15;
  final bool selected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * .1),
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: color),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: selected ? size : 0,
          height: selected ? size : 0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
