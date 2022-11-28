import 'dart:collection';
import 'dart:developer';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:home_work_1/logic/bfs_logic.dart';
import 'package:home_work_1/logic/dfs_logic.dart';
import 'package:home_work_1/logic/dijkstra_logic.dart';
import 'package:home_work_1/structure/structure_main.dart';

class Logic {
  static Stopwatch stopwatchDfs = Stopwatch();
  static int visitedNodesDFS = 0;

  static Stopwatch stopwatchBfs = Stopwatch();
  static int visitedNodesBFS = 0;

  static Stopwatch stopwatchDijkstra = Stopwatch();
  static int visitedNodeDijkstra = 0;

  // -----------------------------DFS ----------------------------------
  List<Structure> dfs(Structure structure) {
    DFS.path.clear();
    DFS.visited.clear();

    stopwatchDfs = new Stopwatch();
    stopwatchDfs.reset();
    stopwatchDfs.start();

    print("StopWatsh: ${stopwatchDfs.elapsed}");
    // Timeline.startSync("dfs_algo");
    List<Structure> result = DFS().dfs(structure);
    visitedNodesDFS = DFS.visited.length;
    stopwatchDfs.stop();
    print("visited:${visitedNodesDFS}");
    print("StopWatsh: ${stopwatchDfs.elapsed}");
    return result;
  }

  // ------------------------------- BFS ------------------------------
  List<Structure> bfs(Structure structure) {
    stopwatchBfs.reset();
    stopwatchBfs.start();

    List<Structure> result = BFS().bfs(structure);
    visitedNodesBFS = BFS.visited.length;

    stopwatchBfs.stop();
    print(visitedNodesBFS);
    print("StopWatsh: ${stopwatchBfs.elapsed}");

    return result;
  }

  List<Structure> dijkstra(Structure structure) {
    stopwatchDijkstra.reset();
    stopwatchDijkstra.start();
    List<Structure> result = Dijkstra().dijkstra(structure);

    visitedNodeDijkstra = Dijkstra.costMap.length;
    stopwatchDijkstra.stop();
    print("StopWatsh: ${stopwatchDijkstra.elapsed}");
    return result;
  }
}
/*
 static List<Structure> pathDfs = [];
  static Stopwatch stopwatchDfs = Stopwatch();
  static List<Structure> pathBfs = [];
  static Set<Structure> visitedDfs = {};
  static HashSet<Structure> visitedBfs = HashSet<Structure>();
  static Stopwatch stopwatchBfs = Stopwatch();
  static HashSet<Structure> visitedDijksta = HashSet<Structure>();
  static PriorityQueue pQueue = PriorityQueue();
  static HashMap<Structure, int> dijkstraMap = HashMap();

  // -----------------------------DFS ----------------------------------
  List<Structure> dfs(Structure structure) {

    print("here init dfs");
    stopwatchDfs.reset();
    stopwatchDfs.start();
    // Timeline.startSync("dfs_algo");
    pathDfs.clear();
    visitedDfs.clear();
    bool ok = dfs_algo(structure, 0);
    stopwatchDfs.stop();
    print("visited:${visitedDfs.length}");
    print("StopWatsh: ${stopwatchDfs.elapsed}");
    return pathDfs;
  }

  bool dfs_algo(Structure structure, int cnt) {
    if (visitedDfs.any((element) => structure.isEqual(element.board))) {
      return false;
    }
    addToDfs(structure);

    bool ok = false;
    if (structure.isFinal()) {
      ok = true;
      pathDfs.add(structure);
      return ok;
    }
    List<Structure> nodes = structure.getNextState();

    for (Structure element in nodes) {
      ok = dfs_algo(element, cnt + 1);
      if (ok == true) {
        pathDfs.add(element);
        break;
      }
    }
    return ok;
  }

  addToDfs(Structure structure) {
    bool ok = visitedDfs.any((element) => element.isEqual(structure.board));
    if (!ok) {
      visitedDfs.add(structure);
    }
  }

  // ------------------------------- BFS ------------------------------
  List<Structure> bfs(Structure structure) {
    stopwatchBfs.reset();
    stopwatchBfs.start();
    pathBfs.clear();
    queue.clear();
    visitedBfs.clear();
    print("here init Bfs");
    Structure? result = bfs_algo(structure, 0);
    if (result == null) return [];
    print(result.board);
    while (result!.perant != null) {
      pathBfs.add(result);
      result = result.perant!;
    }
    print(visitedBfs.length);
    print("StopWatsh: ${stopwatchBfs.elapsed}");
    stopwatchBfs.stop();

    return pathBfs;
  }

  ListQueue queue = ListQueue<Structure>();
  Structure? bfs_algo(Structure structure, int cnt) {
    queue.add(structure);
    visitedBfs.add(structure);
    while (queue.isNotEmpty) {
      Structure currentNode = queue.first;
      queue.removeFirst();
      List<Structure> nodes = currentNode.getNextState();

      for (var element in nodes) {
        if (addToBFS(element)) {
          queue.add(element);
        }
        visitedBfs.add(element);
        if (element.isFinal()) {
          print("Final BFS");
          return element;
        }
      }
    }
    return null;
  }

  bool addToBFS(Structure structure) {
    return !queue.any((element) => element.isEqual(structure.board));
  }

 */