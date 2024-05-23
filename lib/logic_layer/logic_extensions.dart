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

  String toStrAsSingleMode() {
    switch (this) {
      case Player.playerA:
        return "You";
      case Player.playerB:
        return "AI";
    }
  }
}

extension PlayerModeExt on PersonMode {
  int getLevelNum() {
    switch (this) {
      case PersonMode.human:
        return 0;
      case PersonMode.machineRandom:
        return 1;
      case PersonMode.machineIntermediate:
        return 2;
      case PersonMode.machineHard:
        return 3;
    }
  }
}

extension ChoiceNanExt on PlayerMode {
  PlayerMode opposite() {
    switch (this) {
      case PlayerMode.x:
        return PlayerMode.o;
      case PlayerMode.o:
        return PlayerMode.x;
      case PlayerMode.naN:
        return PlayerMode.naN;
    }
  }

  String symbol() {
    switch (this) {
      case PlayerMode.x:
        return 'X';
      case PlayerMode.o:
        return 'O';
      case PlayerMode.naN:
        return '';
    }
  }
}
