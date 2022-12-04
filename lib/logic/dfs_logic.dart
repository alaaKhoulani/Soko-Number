import 'dart:collection';

import 'package:home_work_1/structure/structure_main.dart';

class DFS {
  static List<Structure> path = [];
  static Set visited = Set<Structure>();
  late Structure finalNode;
  List<Structure> dfs(Structure structure) {
    print("here init dfs");
    finalNode = structure;
    bool ok = dfs_algo(structure, 0);
    List<Structure> result = [];
    Structure solution = finalNode;
    while (solution != null) {
      result.add(solution);
      if (solution.perant != null)
        solution = solution.perant!;
      else
        break;
    }
    return path;
  }

  bool dfs_algo(Structure structure, int cnt) {
    if (visited.any((element) => structure.isEqual(element.board))) {
      return false;
    }
    visited.add(structure);
    // addToDfs(structure);

    bool ok = false;
    if (structure.isFinal()) {
      ok = true;
      finalNode = structure;
      path.add(structure);
      return ok;
    }
    List<Structure> nodes = structure.getNextState();

    for (Structure element in nodes) {
      print(cnt);
      ok = dfs_algo(element, cnt + 1);
      if (ok == true) {
        print("oooooooooooooooooooooooooooo");
        path.add(element);
        break;
      }
    }
    return ok;
  }

  addToDfs(Structure structure) {
    bool ok = visited.any((element) => element.isEqual(structure.board));
    if (!ok) {
      visited.add(structure);
    }
  }
}
