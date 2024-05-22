import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/ui/difficulty_screen/view/difficulty_view.dart';
import 'package:tic_tac_toe/ui/difficulty_screen/viewmodel/difficulty_viewmodel.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => DifficultyViewModel()..start(),
        child: const DifficultyView(),
      ),
    );
  }
}
