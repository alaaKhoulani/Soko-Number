import 'dart:collection';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:home_work_1/structure/structure_main.dart';

class Dijkstra {
  static List<Structure> path = [];
  PriorityQueue<CostPair> pQueue =
      PriorityQueue((CostPair cPair1, CostPair cPair2) {
    return cPair2.cost.compareTo(cPair1.cost) + 1;
  });

  static HashSet visited = HashSet<Structure>();
  static HashMap<Structure, int> costMap = HashMap<Structure, int>();

  List<Structure> dijkstra(Structure structure) {
    pQueue.clear();
    visited.clear();
    path.clear();
    costMap.clear();

    CostPair solution = dijkstra_algo(structure, 0);
    Structure result = solution.node;
    while (result.perant != null) {
      path.add(result);
      result = result.perant!;
    }
    return path;
  }

  CostPair dijkstra_algo(Structure structure, int cnt) {
    List<CostPair> listt = [];
    pQueue.add(CostPair(cost: 0, node: structure));
    late CostPair finalNode = CostPair(cost: 0, node: structure);
    while (pQueue.isNotEmpty) {
      // if (cnt == 1) break;
      // print(cnt);
      cnt++;

      CostPair currentNode = pQueue.first;

      // print(currentNode.cost);
      // print(currentNode.node.board);
      // print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
      pQueue.removeFirst();
      int previousCost = getFromMap(currentNode.node) ?? 1000000000;
      if (previousCost < currentNode.cost) {
        continue;
      }
      if (currentNode.node.isFinal()) {
        print("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
        listt.add(currentNode);
        finalNode = currentNode;
        // return finalNode;
      }
      // print(costMap.length);
      // print("${currentNode.cost} + ${currentNode.node.board}");

      List<Structure> nodes = currentNode.node.getNextState();
      for (var element in nodes) {
        int previousChildCost = getFromMap(element) ?? 1000000000;
        int currentChildCost = currentNode.cost + 1;
        if (currentChildCost < previousChildCost) {
          add(CostPair(cost: currentChildCost, node: element));
        }
      }
      // print(costMap.length);
    }
    print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
    print(listt.length);
    print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
    listt.forEach((element) {
      int yy = 0;
      Structure result = element.node;
      while (result.perant != null) {
        yy++;
        // path.add(result);
        result = result.perant!;
      }
      print(yy);
    });

    return finalNode;
  }

  add(CostPair costPair) {
    bool ok = false;
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
      print('ppppppppppppppppppppppppppppppppppppp');
      pQueue.add(costPair);
    }
    if (!ok) {
      pQueue.add(costPair);
      costMap.addAll({costPair.node: costPair.cost});
    }
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
