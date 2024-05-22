import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/ui/home_screen/view/home_view.dart';
import 'package:tic_tac_toe/ui/home_screen/viewmodel/home_states.dart';
import 'package:tic_tac_toe/ui/home_screen/viewmodel/home_viewmodel.dart';
import 'package:tic_tac_toe/ui/resources/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeViewModel(),
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          HomeViewModel viewModel = HomeViewModel.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: viewModel.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: Scaffold(
              body: const HomeView(),
              floatingActionButton: FloatingActionButton(
                onPressed: viewModel.toggleThemeMode,
                child: viewModel.themeMode == ThemeMode.light
                    ? const Icon(Icons.dark_mode_rounded)
                    : const Icon(Icons.light_mode_rounded),
              ),
            ),
          );
        },
      ),
    );
  }
}
