import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/ui/choice_screen/view/choice_view.dart';
import 'package:tic_tac_toe/ui/choice_screen/viewmodel/choice_viewmodel.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ChoiceViewModel(),
        child: const ChoiceView(),
      ),
    );
  }
}
