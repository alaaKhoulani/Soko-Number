import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_work_1/constants/colors.dart';
import 'package:home_work_1/structure/structure_main.dart';

class BoardWidget extends StatefulWidget {
  final Structure structure;
  final int width, heigh;
  const BoardWidget(
      {super.key,
      required this.structure,
      required this.width,
      required this.heigh});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  int isGoal(int i, int j) {
    for (int k = 0; k < widget.structure.goals.length; k++) {
      if (widget.structure.goals[k].first == i &&
          widget.structure.goals[k].second == j)
        return widget.structure.goals[k].value;
    }
    return -1;
  }

  Widget createTable() {
    List<TableRow> rows = [];

    for (int i = 0; i < widget.structure.board.length; ++i) {
      List<Widget> row = [];
      for (int j = 0; j < widget.structure.board[i].length; j++) {
        row.add(Container(
          width: 20,
          height: 40,
          child: widget.structure.board[i][j].isNumeric
              ? Center(
                  child: Text(
                    (int.parse(widget.structure.board[i][j])).toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : isGoal(i, j) != -1
                  ? Center(
                      child: Text(
                        (isGoal(i, j).abs()).toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : null,
          decoration: BoxDecoration(
              color: widget.structure.board[i][j] == "W"
                  ? pinkk
                  : widget.structure.board[i][j].isNumeric
                      ? Colors.purple
                      : isGoal(i, j) != -1? Color.fromARGB(255, 180, 179, 179): Colors.grey[300]),
        ));
      }
      rows.add(TableRow(children: row));
    }
    // for (int i = 0; i < widget.structure.rows; ++i) {
    //   rows.add(TableRow(
    //       children: widget.structure.board[i]
    //           .map((e) => Container(
    //                 width: 20,
    //                 height: 40,
    //                 child: e.isNumeric
    //                     ? Center(
    //                         child: Text(
    //                           (int.parse(e).abs()).toString(),
    //                           style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 30,
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                       )
    //                     : null,
    //                 decoration: BoxDecoration(
    //                     color: e == "W"
    //                         ? pinkk
    //                         : e.isNumeric
    //                             ? Colors.amber
    //                             : Colors.grey[300]),
    //               ))
    //           .toList()));
    // }
    return Table(children: rows);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: createTable(),
    );
  }
}
