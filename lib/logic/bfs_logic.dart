import 'dart:collection';

import 'package:home_work_1/structure/structure_main.dart';

class BFS {
  static List<Structure> path = [];
  static HashSet visited = HashSet<Structure>();

  List<Structure> bfs(Structure structure) {
    path.clear();
    queue.clear();
    visited.clear();
    print("here init Bfs");
    Structure? result = bfs_algo(structure, 0);
    if (result == null) return [];
    print(result.board);
    while (result!.perant != null) {
      path.add(result);
      result = result.perant!;
    }
    print(visited.length);

    return path;
  }

  ListQueue queue = ListQueue<Structure>();

  Structure? bfs_algo(Structure structure, int cnt) {
    queue.add(structure);
    // visited.add(structure);
    while (queue.isNotEmpty) {
      Structure currentNode = queue.first;
      queue.removeFirst();
      List<Structure> nodes = currentNode.getNextState();

        visited.add(currentNode);
      if (currentNode.isFinal()) {
        return currentNode;
      }
      for (var element in nodes) {
        if (addToBFS(element)) {
          queue.add(element);
        }
      }
    }
    return null;
  }

  bool addToBFS(Structure structure) {
    return !visited.any((element) => element.isEqual(structure.board));
  }
}
