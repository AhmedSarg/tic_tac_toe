import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/ui/home_screen/viewmodel/home_states.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel() : super(InitialState());

  static HomeViewModel get(context) => BlocProvider.of(context);

  ThemeMode? _themeMode;

  ThemeMode get themeMode => _themeMode ?? ThemeMode.light;

  late SharedPreferences _sharedPreferences;

  start() async {
    emit(LoadingState());
    _sharedPreferences = await SharedPreferences.getInstance();
    _themeMode = _sharedPreferences.get('theme') == 'light'
        ? ThemeMode.light
        : ThemeMode.dark;
    emit(InitialState());
  }

  void toggleThemeMode() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      _sharedPreferences.setString('theme', 'dark');
    } else {
      _themeMode = ThemeMode.light;
      _sharedPreferences.setString('theme', 'light');
    }
    emit(ChangeThemeState());
  }
}
