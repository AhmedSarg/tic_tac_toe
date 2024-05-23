import 'package:flutter/material.dart';

import 'package:tic_tac_toe/ui/home_screen/view/home_screen.dart';
import 'package:tic_tac_toe/ui/resources/audio_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AudioManager.instance.init();

  runApp(const HomeScreen());
}
