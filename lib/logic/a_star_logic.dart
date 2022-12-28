import 'dart:collection';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:home_work_1/logic/dijkstra_logic.dart';
import 'package:home_work_1/structure/structure_main.dart';

class AStar {
  static List<Structure> path = [];
  static HashSet visited = HashSet<Structure>();
  PriorityQueue<Triple> pQueue =
      PriorityQueue((Triple triple1, Triple triple2) {

    int temp =(triple2.cost + triple2.heuristic)
        .compareTo(triple1.cost + triple1.heuristic);
    if (temp == 1) {
    return 2 + triple2.heuristic.compareTo(triple1.heuristic);
    }
    return 2 + temp;
  });
  static HashMap<Structure, int> costMap = HashMap<Structure, int>();

  List<Structure> a_star(Structure structure) {
    pQueue.clear();
    visited.clear();
    path.clear();
    costMap.clear();

    Triple? solution = a_star_algo(structure);
    if (solution == null) return [];

    Structure result = solution.node;
    while (result.perant != null) {
      path.add(result);
      result = result.perant!;
    }
    return path;
  }

  Triple a_star_algo(Structure structure) {
    Triple parentNode = Triple  (
        cost: structure.depth,
        heuristic: structure.calculateHeuristic(),
        node: structure);
        
    pQueue.add(parentNode);
    costMap.addAll({structure: parentNode.cost + parentNode.heuristic});

    late Triple finalNode = parentNode;

    while (pQueue.isNotEmpty) {
      Triple currentNode = pQueue.first;
      pQueue.removeFirst();
      print(currentNode.node.board);
      print("heuristic");
      print(currentNode.heuristic);
      print(currentNode.node.calculateHeuristic());
      int previousScore = getFromMap(currentNode.node) ?? 1000000000;
      int currentScore = currentNode.cost + currentNode.heuristic;
      if (currentScore > previousScore) {
        continue;
      }

      if (currentNode.node.isFinal()) {
        print("FFFFFFFFFFFFFFFFFFFFFFFFFFFFffinal");
        finalNode = currentNode;
        break;
      }
      List<Structure> nodes = currentNode.node.getNextState();
      for (var element in nodes) {
        int previosChildScore = getFromMap(element) ?? 1000000000;
        int currentChildCost = element.depth; //calc_cost(element);
        int currentChildHeuristic = element.calculateHeuristic();
        int currentChildScore = currentChildCost + currentChildHeuristic;

        if (currentChildScore < previosChildScore) {
          print("if");
          add(Triple(
              cost: currentChildCost,
              heuristic: currentChildHeuristic,
              node: element));
        }
      }
    }

    return finalNode;
  }

  // add(CostPair costPair) {
  //   bool ok = false;
  //   costMap.forEach((key, value) {
  //     if (costPair.node.isEqual(key.board)) {
  //       ok = true;
  //       value = costPair.cost;
  //       pQueue.toList().forEach((element) {11
  //         if (element.node.isEqual(costPair.node.board)) {
  //           element.cost = costPair.cost;
  //           return;
  //         }
  //       });
  //       return;
  //     }
  //   });
  //   if (ok) {
  //     costMap.addAll({costPair.node: costPair.cost});
  //     pQueue.add(costPair);
  //   }
  // }

  add(Triple node) {
    bool ok = false;
    costMap.forEach((key, value) {
      if (key.isEqual(node.node.board)) {
        //update cost in map
        costMap[key] = node.cost + node.heuristic;

        pQueue.toList().forEach((element) {
          if (element.node.isEqual(key.board)) {
            element.cost = node.cost + node.heuristic;
            return;
          }
        });

        ok = true;
        return;
      }
    });
    if (node.node.isFinal() && ok) {
      pQueue.add(node);
    }
    if (!ok) {
      pQueue.add(node);
      costMap.addAll({node.node: node.cost + node.heuristic});
    }
  }

  int calc_cost(Structure structure) {
    int h = structure.calculateHeuristic();
    int c = structure.depth + h;
    // print(structure.board);
    // print("cccccccccccccccccccccccc= ${structure.depth}  + $h ==== $c");
    return c;
  }

  // int hurestic(Structure structure) {
  //   CostPair result = Dijkstra().dijkstra_algo(structure, 0);
  //   // if (result == null) return 0;
  //   int cnt = 0;
  //   Structure? resultNode = result.node;
  //   // print("in he ${resultNode.isFinal()}");
  //   while (resultNode != null) {
  //     cnt++;
  //     resultNode = resultNode.perant;
  //   }
  //   // print("$cnt  ==== ${structure.depth}");
  //   return cnt - structure.depth;
  //   // return result.node.depth - structure.depth;
  // }

  getFromMap(Structure structure) {
    int? resultCost = null;
    costMap.forEach((key, value) {
      if (key.isEqual(structure.board)) {
        resultCost = value;
        return;
      }
    });
    return resultCost;
  }
}

class Triple {
  int cost;
  int heuristic;
  Structure node;
  Triple({required this.cost, required this.heuristic, required this.node});
}
