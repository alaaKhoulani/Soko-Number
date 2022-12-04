import 'dart:collection';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:home_work_1/logic/a_star_logic.dart';
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

  static Stopwatch stopwatchAStar = Stopwatch();
  static int visitedNodeAStar = 0;

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

  List<Structure> a_star(Structure structure) {
    print("Astar started");
    stopwatchAStar.reset();
    stopwatchAStar.start();
    List<Structure> result = AStar().a_star(structure);

    visitedNodeAStar = AStar.costMap.length;
    stopwatchAStar.stop();
    print("StopWatsh: ${stopwatchDijkstra.elapsed}");
    return result;
  }
}
