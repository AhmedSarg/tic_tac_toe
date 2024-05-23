import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/logic_layer/logic_extensions.dart';

import 'logic_layer/logic_constants.dart';
import 'logic_layer/logic_enums.dart';
import 'logic_layer/xo_gameplay.dart';

void test1() {
  XOGamePlay gamePlay = XOGamePlay.start(
    playerA: PersonMode.machineHard,
    playerB: PersonMode.human,
    playerAChoice: PlayerMode.o,
    onGameEnd: (gamePlay) {
      if (kDebugMode) {
        print("\n" * 2);
      }
      if (kDebugMode) {
        if (kDebugMode) {
          print("-" * 30);
        }
      }
      if (kDebugMode) {
        print("\t\tGame Ended");
      }
      if (kDebugMode) {
        print("Status: \t\t${gamePlay.getGameStatus()}");
      }
      if (kDebugMode) {
        print("Game Stopped: \t${gamePlay.isGameStopped()}");
      }
      if (kDebugMode) {
        print("Waiting Human: \t${gamePlay.isWaitingHumanInput()}");
      }
      if (kDebugMode) {
        print("Current Role: \t${gamePlay.getCurrentChoice()}");
      }
      if (kDebugMode) {
        print("Winner Tiles: \t${gamePlay.getWinnerTiles()}");
      }
      if (kDebugMode) {
        print("-" * 30);
      }
    },
  );

  while (gamePlay.isGameStopped() == false) {
    if (kDebugMode) {
      print("\n\n\n");
    }
    if (kDebugMode) {
      print("Status: \t\t${gamePlay.getGameStatus()}");
    }
    if (kDebugMode) {
      print("Game Stopped: \t${gamePlay.isGameStopped()}");
    }
    if (kDebugMode) {
      print("Waiting Human: \t${gamePlay.isWaitingHumanInput()}");
    }
    if (kDebugMode) {
      print("Current Role: \t${gamePlay.getCurrentChoice()}");
    }

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

void main() {
  //test watch mode
  XOGamePlay gamePlay = XOGamePlay.start(
    playerA: PersonMode.machineRandom,
    playerB: PersonMode.machineHard,
    playerAChoice: PlayerMode.o,
    onGameEnd: (gamePlay) {
      if (kDebugMode) {
        print("\n" * 2);
      }
      if (kDebugMode) {
        print("-" * 30);
      }
      if (kDebugMode) {
        print("\t\tGame Ended");
      }
      if (kDebugMode) {
        print("Status: \t\t${gamePlay.getGameStatus()}");
      }
      if (kDebugMode) {
        print("Game Stopped: \t${gamePlay.isGameStopped()}");
      }
      if (kDebugMode) {
        print("Waiting Human: \t${gamePlay.isWaitingHumanInput()}");
      }
      if (kDebugMode) {
        print("Current Role: \t${gamePlay.getCurrentChoice()}");
      }
      if (kDebugMode) {
        print("Winner Tiles: \t${gamePlay.getWinnerTiles()}");
      }
      if (kDebugMode) {
        print("-" * 30);
      }
    },
  );

  var history = gamePlay.watchAIvsAI();

  for (var item in history.history) {
    item.displayToConsole();
  }
}
