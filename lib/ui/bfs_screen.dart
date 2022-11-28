import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_work_1/constants/colors.dart';
import 'package:home_work_1/constants/levels.dart';
import 'package:home_work_1/logic/logic_main.dart';
import 'package:home_work_1/structure/structure_main.dart';
import 'package:home_work_1/ui/levels_screen.dart';
import 'package:home_work_1/ui/widgets/board_widget.dart';

class BFSScreen extends StatefulWidget {
  int level_ind = 0;
  Structure currentBoard = level1;
  Structure currentLevel;
  BFSScreen({super.key, required this.currentLevel, required this.level_ind});

  @override
  State<BFSScreen> createState() => _BFSScreenState();
}
//0:00:00.458413
//0:00:03.088994

class _BFSScreenState extends State<BFSScreen> {
  Logic logic = Logic();
  bool done = false;
  int visited = 0;

  List<Structure> path = [];
  int index = 0;
  late Timer timer;
  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    widget.currentBoard = widget.currentLevel;
    playBFS();
    setState(() {
      visited = Logic.visitedNodesBFS;
    });
    timer = Timer.periodic(Duration(milliseconds: 500), (tim) {
      
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
        //     playBFS();
        //   });
        // }
      }
    });
    super.initState();
  }

  playBFS() {
    path.clear();
    path = logic.bfs(widget.currentLevel);
    path.add(widget.currentLevel);
    index = path.length - 1;
    print("length pf path isss ${path.length}");
    
    print(Logic.visitedNodesBFS);
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
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "BFS",
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
                            "Time of Excute: ${Logic.stopwatchBfs.elapsed}",
                            style: detailsStyle))
                    : Container(),
                done
                    ? detailsContainer(
                        child: Text("Depth    :    ${path.length - 1}",
                            style: detailsStyle))
                    : Container(),
              ],
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
