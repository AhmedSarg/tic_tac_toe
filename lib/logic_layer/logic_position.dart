class GridPos {
  final int i, j;

  GridPos(this.i, this.j);

  @override
  String toString() {
    return "($i ,$j)";
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (other is GridPos ) return i == other.i && j == other.j;
    return false;
  }
}
