import 'logic_enums.dart';

extension PlayerExt on Player {
  Player opposite() {
    switch (this) {
      case Player.playerA:
        return Player.playerB;
      case Player.playerB:
        return Player.playerA;
    }
  }
}

extension PlayerModeExt on PlayerMode {
  int getLevelNum() {
    switch (this) {
      case PlayerMode.human:
        return 0;
      case PlayerMode.machineRandom:
        return 1;
      case PlayerMode.machineIntermediate:
        return 2;
      case PlayerMode.machineHard:
        return 3;
    }
  }
}

extension ChoiceNanExt on Choice {
  Choice opposite() {
    switch (this) {
      case Choice.x:
        return Choice.o;
      case Choice.o:
        return Choice.x;
      case Choice.naN:
        return Choice.naN;
    }
  }

  String symbol() {
    switch (this) {
      case Choice.x:
        return 'x';
      case Choice.o:
        return 'o';
      case Choice.naN:
        return '-';
    }
  }
}
