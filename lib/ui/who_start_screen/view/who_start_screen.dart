import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/ui/who_start_screen/view/who_start_view.dart';

import '../viewmodel/who_start_viewmodel.dart';

class WhoStartScreen extends StatelessWidget {
  const WhoStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => WhoStartViewModel(),
        child: const WhoStartView(),
      ),
    );
  }
}
