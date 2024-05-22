import 'dart:io';

import 'package:tic_tac_toe/logic_layer/logic_extensions.dart';

import 'logic_layer/logic_constants.dart';
import 'logic_layer/logic_enums.dart';
import 'logic_layer/xo_gameplay.dart';

void testGamePlay() {
  XOGamePlay gamePlay = XOGamePlay.start(
    playerA: PlayerMode.human,
    playerB: PlayerMode.machineHard,
    startPlayer: Player.playerA,
    playerAChoice: Choice.o,
    onGameEnd: (gamePlay) {
      print("\n" * 2);
      print("-" * 30);
      print("\t\tGame Ended");
      print("Status: \t\t${gamePlay.getGameStatus()}");
      print("Game Stopped: \t${gamePlay.isGameStopped()}");
      print("Waiting Human: \t${gamePlay.isWaitingHumanInput()}");
      print("Current Role: \t${gamePlay.getCurrentChoice()}");
      print("-" * 30);
    },
  );

  while (gamePlay.isGameStopped() == false) {
    print("\n\n\n");
    print("Status: \t\t${gamePlay.getGameStatus()}");
    print("Game Stopped: \t${gamePlay.isGameStopped()}");
    print("Waiting Human: \t${gamePlay.isWaitingHumanInput()}");
    print("Current Role: \t${gamePlay.getCurrentChoice()}");

    //print grid
    for (int i = 0; i < gridHeight; i++) {
      stdout.write(" " * 10);
      for (int j = 0; j < gridWidth; j++) {
        stdout.write(gamePlay.getTile(i, j).symbol());
        stdout.write(" ");
      }
      stdout.write("\n");
    }
    if (gamePlay.isWaitingHumanInput()) {
      bool done = false;
      do {
        stdout.write("Enter position(ij): ");
        int num = int.parse(stdin.readLineSync() ?? '00');
        int i = (num / 10).truncate();
        int j = num % 10;
        done = gamePlay.setTile(i, j);
      } while (done == false);
    }

    gamePlay.update();
  }

  stdout.write("\n\nEnter key to end");
  stdin.readLineSync();
}
