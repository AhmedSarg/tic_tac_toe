import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/logic/data_intent.dart';
import 'package:tic_tac_toe/ui/choice_screen/view/choice_screen.dart';
import 'package:tic_tac_toe/ui/difficulty_screen/viewmodel/difficulty_viewmodel.dart';

import '../../../logic_layer/logic_enums.dart';

class DifficultyView extends StatelessWidget {
  const DifficultyView({super.key});

  static late DifficultyViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = DifficultyViewModel.get(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: CarouselSlider(
              carouselController: viewModel.carouselController,
              items: const [
                DifficultyLevelWidget(
                  index: 0,
                  text: 'Easy',
                  color: Colors.green,
                ),
                DifficultyLevelWidget(
                  index: 1,
                  text: 'Medium',
                  color: Colors.orange,
                ),
                DifficultyLevelWidget(
                  index: 2,
                  text: 'Hard',
                  color: Colors.red,
                ),
              ],
              options: CarouselOptions(
                viewportFraction: .8,
                enableInfiniteScroll: false,
                onPageChanged: (index, _) {
                  if (index == 0) {
                    DataIntent.setDifficultyLevel = DifficultyLevel.easy;
                  } else if (index == 1) {
                    DataIntent.setDifficultyLevel = DifficultyLevel.medium;
                  } else if (index == 2) {
                    DataIntent.setDifficultyLevel = DifficultyLevel.hard;
                  } else {
                    DataIntent.setDifficultyLevel = DifficultyLevel.easy;
                  }
                },
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              const Text('Choose the Difficulty Level'),
              const Spacer(flex: 8),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width - 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChoiceScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class DifficultyLevelWidget extends StatelessWidget {
  const DifficultyLevelWidget({
    super.key,
    required this.text,
    required this.color,
    required this.index,
  });

  final String text;
  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: index == 0 ? const Radius.circular(25) : Radius.zero,
              right: index == 2 ? const Radius.circular(25) : Radius.zero,
            ),
            color: color,
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
      ),
    );
  }
}
