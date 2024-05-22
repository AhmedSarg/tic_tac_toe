import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/ui/home_screen/viewmodel/home_states.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel() : super(InitialState());

  static HomeViewModel get(context) => BlocProvider.of(context);

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleThemeMode() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    emit(ChangeThemeState());
  }
}
