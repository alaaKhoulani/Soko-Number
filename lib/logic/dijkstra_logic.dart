import 'dart:collection';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:home_work_1/structure/structure_main.dart';

class Dijkstra {
  static List<Structure> path = [];
  PriorityQueue<CostPair> pQueue =
      PriorityQueue((CostPair cPair1, CostPair cPair2) {
    return cPair2.cost.compareTo(cPair1.cost) + 2;
  });

  static HashSet visited = HashSet<Structure>();
  static HashMap<Structure, int> costMap = HashMap<Structure, int>();

  reset() {
    pQueue.clear();
    visited.clear();
    path.clear();
    costMap.clear();
  }

  List<Structure> dijkstra(Structure structure) {
    reset();

    CostPair solution = dijkstra_algo(structure, 0);
    if (!solution.node.isFinal()) return [];

    Structure result = solution.node;
    while (result.perant != null) {
      path.add(result);
      result = result.perant!;
    }
    return path;
  }

  CostPair dijkstra_algo(Structure structure, int cnt) {
    reset();
    List<CostPair> listt = [];
    pQueue.add(CostPair(cost: 0, node: structure));
    costMap.addAll({structure: 0});
    late CostPair finalNode = CostPair(cost: 0, node: structure);

    while (pQueue.isNotEmpty) {
      CostPair currentNode = pQueue.first;
      pQueue.removeFirst();
      
      int previousCost = getFromMap(currentNode.node) ?? 1000000000;
      if (previousCost < currentNode.cost) {
        continue;
      }
      
      if (currentNode.node.isFinal()) {
        listt.add(currentNode);
        // print("FFFFFFFFFFFFFFFFFFFFFF");
        finalNode = currentNode;
        // return finalNode;
      }

      List<Structure> nodes = currentNode.node.getNextState();
      for (var element in nodes) {
        int previousChildCost = getFromMap(element) ?? 1000000000;
        int currentChildCost = currentNode.cost + 1;
        // print(element.isFinal());
        if (currentChildCost < previousChildCost ) {
          add(CostPair(cost: currentChildCost, node: element));
        }
      }
    }

    // for (var element in listt) {
    //   int cnt = 0;
    //   Structure? resultNode = element.node;
    //   while (resultNode != null) {
    //     cnt++;
    //     resultNode = resultNode.perant;
    //   }
    //   // print(cnt);
    // }
    return finalNode;
  }

  add(CostPair costPair) {
    bool ok = false;
    // print("size pq before= ${pQueue.length}");
    costMap.forEach((key, value) {
      if (key.isEqual(costPair.node.board)) {
        //update cost in map
        costMap[key] = costPair.cost;

        pQueue.toList().forEach((element) {
          if (element.node.isEqual(key.board)) {
            element.cost = costPair.cost;
            return;
          }
        });

        ok = true;
        return;
      }
    });
    if (costPair.node.isFinal() && ok) {
      pQueue.add(costPair);
    }
    if (!ok) {
      pQueue.add(costPair);
      costMap.addAll({costPair.node: costPair.cost});
    }
    // print("size pq after= ${pQueue.length}");
  }

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

class CostPair {
  int cost;
  Structure node;
  CostPair({required this.cost, required this.node});
}

