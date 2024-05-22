import 'logic_grid.dart';

class PlayHistory {
  final List<PlayGrid> history;

  PlayHistory(this.history);

  void snapshotClone(PlayGrid grid) {
    history.add(grid.clone());
  }
}
