import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/logic_layer/data_intent.dart';
import 'package:tic_tac_toe/ui/game_screen/view/game_screen.dart';
import 'package:tic_tac_toe/ui/resources/assets_manager.dart';

class NamesScreen extends StatelessWidget {
  const NamesScreen({super.key});

  static final FocusNode _xNameFocus = FocusNode();
  static final FocusNode _oNameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Type your Names',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    const Text('Who will be '),
                    Lottie.asset(
                      AssetsManager.xLottie,
                      repeat: false,
                      width: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller:
                      TextEditingController(text: DataIntent.getPlayerAName),
                  focusNode: _xNameFocus,
                  onSubmitted: (v) {
                    _xNameFocus.unfocus();
                    _oNameFocus.requestFocus();
                  },
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      DataIntent.setPlayerAName = v;
                    } else {
                      DataIntent.setPlayerAName = null;
                    }
                  },
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Text('Who will be '),
                    Lottie.asset(
                      AssetsManager.oLottie,
                      repeat: false,
                      width: 30,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller:
                      TextEditingController(text: DataIntent.getPlayerBName),
                  focusNode: _oNameFocus,
                  onSubmitted: (v) {
                    _oNameFocus.unfocus();
                  },
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      DataIntent.setPlayerBName = v;
                    } else {
                      DataIntent.setPlayerBName = null;
                    }
                  },
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                    ),
                    child: Text(
                      'Next',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
