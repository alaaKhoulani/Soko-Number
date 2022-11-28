import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_work_1/constants/colors.dart';
import 'package:home_work_1/constants/levels.dart';
import 'package:home_work_1/logic/logic_main.dart';
import 'package:home_work_1/structure/structure_main.dart';
import 'package:home_work_1/ui/levels_screen.dart';
import 'package:home_work_1/ui/widgets/board_widget.dart';

class DijkstraScreen extends StatefulWidget {
  int level_ind;
  Structure currentBoard = level1;
  Structure currentLevel;
  DijkstraScreen({super.key, required this.currentLevel, required this.level_ind});

  @override
  State<DijkstraScreen> createState() => _DijkstraScreenState();
}

class _DijkstraScreenState extends State<DijkstraScreen> {
  Logic logic = Logic();
  bool done = false;
  List<Structure> path = [];
  int index = 0;
  int visited = 0;
  late Stopwatch stopwatch;
  late Timer timer;
  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    print('Cansel');
    super.dispose();
  }

  @override
  void initState() {
    widget.currentBoard = widget.currentLevel;
    playDijkstra();

    // print("=============================================");
    // timer=
    timer = Timer.periodic(Duration(milliseconds: 500), (tim) {
      print(index);
      // stopwatch = Logic.stopwatchDijkstra;
      // stopwatch.stop();
      visited = Logic.visitedNodeDijkstra;
      if (index - 1 >= 0) {
        setState(() {
          done = true;
          index--;
          print(path[index].board);
        });
      } else {
        timer.cancel();
        // if (widget.level_ind + 1 >= levels.length)
        //   timer.cancel();
        // else {
        //   setState(() {
        //     print("new");
        //     widget.level_ind++;
        //     if (widget.level_ind >= levels.length) {
        //       Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute<void>(
        //             builder: (BuildContext context) => const LevelsScreen(),
        //           ));
        //     }
        //     widget.currentLevel = levels[widget.level_ind];
        //     playDijkstra();
        //   });
        // }
      }
    });
    super.initState();
  }

  playDijkstra() {
    path.clear();
    path = logic.dijkstra(widget.currentLevel);
    path.add(widget.currentLevel);
    index = path.length - 1;
    print("length pf path is ${path.length}");
    // for (int i = 0; i < path.length; i++) {
    //   print(path[i].board);
    // }
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 191, 191, 191),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "level ${widget.level_ind + 1}",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
        child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Dijkstra",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  BoardWidget(
                    structure: path[index],
                    width: 20,
                    heigh: 40,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  done
                      ? detailsContainer(
                          child: Text("Viseted Nodes     :    ${visited}",
                              style: detailsStyle))
                      : Container(),
                  done
                      ? detailsContainer(
                          child: Text(
                              "Time of Excute: ${Logic.stopwatchDijkstra.elapsed}",
                              style: detailsStyle))
                      : Container(),
                  done
                      ? detailsContainer(
                          child: Text("Depth    :    ${path.length - 1}",
                              style: detailsStyle))
                      : Container(),
                ],
              ),
            )),
      )),
    );
  }

  Widget detailsContainer({required Widget child}) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: child,
    );
  }
}
