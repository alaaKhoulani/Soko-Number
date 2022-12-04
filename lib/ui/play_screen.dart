import 'package:flutter/material.dart';
import 'package:home_work_1/constants/colors.dart';
import 'package:home_work_1/constants/levels.dart';
import 'package:home_work_1/structure/structure_main.dart';
import 'package:home_work_1/ui/a_star_screen.dart';
import 'package:home_work_1/ui/bfs_screen.dart';
import 'package:home_work_1/ui/dfs_screen.dart';
import 'package:home_work_1/ui/dijkstra_screen.dart';
import 'package:home_work_1/ui/levels_screen.dart';
import 'package:home_work_1/ui/widgets/board_widget.dart';

class PlayingScreen extends StatefulWidget {
  Structure currentLevel;
  Structure currentBoard = level1;
  int index = 0;
  PlayingScreen({super.key, required this.currentLevel, required this.index});

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  int i = 0;
  @override
  void initState() {
    // TODO: implement initState
    widget.currentBoard = widget.currentLevel;
    i = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 191, 191, 191),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "level ${i+1}",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          // check move
          IconButton(
            onPressed: () async {
              List<bool> moves = widget.currentBoard.checkMoves();
              await _showMyDialogMoves(context, moves);
            },
            icon: Icon(
              Icons.lightbulb,
              color: Color.fromARGB(255, 244, 221, 17),
            ),
          ),
          // Next states
          IconButton(
              onPressed: () async {
                List<Structure> nextStates = widget.currentBoard.getNextState();
                await _showMyDialogNextStates(context, nextStates);
              },
              icon: Icon(
                Icons.queue_play_next,
                // color: pinkk,
              )),
          DropdownButton(
              iconSize: 30,
              underline: null,
              elevation: 0,
              // hint: Text(" "),
              icon: Icon(
                Icons.edit_note,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                  value: "play",
                  child: Text("Play"),
                ),
                DropdownMenuItem(
                  value: "DFS",
                  child: Text("DFS"),
                ),
                DropdownMenuItem(
                  value: "BFS",
                  child: Text("BFS"),
                  // onTap: () {},
                ),
                DropdownMenuItem(value: "Dijkstra", child: Text("Dijkstra")),
                DropdownMenuItem(value: "A*", child: Text("A*")),
              ],
              onChanged: (value) {
                if (value == "BFS") {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => BFSScreen(
                        currentLevel: widget.currentLevel,
                        level_ind: i,
                      ),
                    ),
                  );
                } else if (value == "DFS") {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => DFSScreen(
                        currentLevel: widget.currentLevel,
                        level_ind: i,
                      ),
                    ),
                  );
                }
                 else if (value == "Dijkstra") {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => DijkstraScreen(
                        currentLevel: widget.currentLevel,
                        level_ind: i,
                      ),
                    ),
                  );
                }
                 else if (value == "A*") {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => AStarScreen(
                        currentLevel: widget.currentLevel,
                        level_ind: i,
                      ),
                    ),
                  );
                }
              })
          // IconButton(
          //     onPressed: () {
          //       ;
          //     },
          //     icon: Icon(Icons.edit_note))
        ],
      ),
      body: SafeArea(
          child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Container(
                padding: EdgeInsets.all(20),
                child: BoardWidget(
                  structure: widget.currentBoard,
                  width: 20,
                  heigh: 40,
                )),
          ),
          Positioned(
            bottom: 20,
            right: 110,
            child: Center(child: arrows()),
          )
        ],
      )),
    );
  }

  Widget arrows() {
    return Center(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                width: 50,
                height: 50,
              ),
              arrowButton(
                  icon: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                  function: () {
                    setState(() {
                      widget.currentBoard = widget.currentBoard.moveUp();
                    });
                  }),
              Container(
                margin: EdgeInsets.all(5),
                width: 50,
                height: 50,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              arrowButton(
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                  ),
                  function: () {
                    setState(() {
                      widget.currentBoard = widget.currentBoard.moveLeft();
                    });
                  }),
              arrowButton(
                  icon: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  function: () {
                    setState(() {
                      widget.currentBoard = widget.currentBoard.moveDown();
                    });
                  }),
              arrowButton(
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                  function: () {
                    setState(() {
                      widget.currentBoard = widget.currentBoard.moveRight();
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Widget arrowButton({required Icon icon, required Function function}) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: pinkk),
      child: TextButton(
        onPressed: () async {
          function.call();
          if (widget.currentBoard.isFinal()) {
            await _showMyDialog(context);
          }
        },
        child: icon,
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          // height: 300,
          child: AlertDialog(
            title: Text(
              "Congrats",
              style: TextStyle(
                  color: pinkk, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            content: Container(
              height: 35,
              child: Column(
                children: [
                  Text(
                    "Next Level :",
                    style: TextStyle(
                        color: Color.fromARGB(255, 195, 192, 192),
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: pinkk,
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      i++;
                      if (i < levels.length) {
                        widget.currentBoard = levels[i];
                        widget.currentLevel = levels[i];
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const LevelsScreen(),
                          ),
                        );
                      }
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showMyDialogMoves(
      BuildContext context, List<bool> moves) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Possible Moves",
            style: TextStyle(
                color: pinkk, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          content: Container(
            height: 35,
            width: 200,
            child: Row(
              children: [
                moves[0] == true
                    ? Text(
                        "UP - ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 195, 192, 192),
                            fontSize: 20),
                      )
                    : Container(),
                moves[1] == true
                    ? Text(
                        "Down - ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 195, 192, 192),
                            fontSize: 20),
                      )
                    : Container(),
                moves[2] == true
                    ? Text(
                        "Left - ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 195, 192, 192),
                            fontSize: 20),
                      )
                    : Container(),
                moves[3] == true
                    ? Text(
                        "Right - ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 195, 192, 192),
                            fontSize: 20),
                      )
                    : Container(),
              ],
            ),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: pinkk,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogNextStates(
      BuildContext context, List<Structure> nextStates) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Next States",
            style: TextStyle(
                color: pinkk, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: nextStates
                  .map((e) => Column(
                        children: [
                          BoardWidget(
                            structure: e,
                            width: 13,
                            heigh: 25,
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ))
                  .toList(),
            ),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: pinkk,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
