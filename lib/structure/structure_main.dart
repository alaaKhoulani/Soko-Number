import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../constants/pair.dart';

class Structure {
  int rows, columns;
  // String? lable;
  List<List<String>> board;
  List<Pair> goals;
  List<Pair> numbers;
  Structure? perant;
  int depth;

  Structure(
      {required this.rows,
      required this.columns,
      required this.board,
      required this.perant,
      required this.depth,
      required this.numbers,
      required this.goals});

  List<bool> checkMoves() {
    // up    down   left  right
    List<bool> result = [false, false, false, false];
    bool ok = false;
    //Up
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].first - 1 >= 0 &&
          board[numbers[i].first - 1][numbers[i].second] != "W" &&
          !board[numbers[i].first - 1][numbers[i].second].isNumeric) {
        result[0] = true;
        break;
      }
    }
    // for (int i = 0; i < board.length; i++) {
    //   for (int j = 0; j < board[i].length; j++) {
    //     if (board[i][j].isNumeric &&
    //         i - 1 >= 0 &&
    //         board[i - 1][j] != "W" &&
    //         !board[i - 1][j].isNumeric) {
    //       print("UP here");
    //       result[0] = true;
    //       ok = true;
    //       break;
    //     }
    //     if (ok) break;
    //   }
    // }
    // ok = false;
    // Down
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].first + 1 < rows &&
          board[numbers[i].first + 1][numbers[i].second] != "W" &&
          !board[numbers[i].first + 1][numbers[i].second].isNumeric) {
        result[1] = true;
        break;
      }
    }
    // for (int i = 0; i < board.length; i++) {
    //   for (int j = 0; j < board[i].length; j++) {
    //     if (board[i][j].isNumeric &&
    //         i + 1 < rows &&
    //         board[i + 1][j] != "W" &&
    //         !board[i + 1][j].isNumeric) {
    //       print("Down here");
    //       result[1] = true;
    //       ok = true;
    //       break;
    //     }
    //   }
    //   if (ok) break;
    // }
    // ok = false;
    //Left
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].second - 1 >= 0 &&
          board[numbers[i].first][numbers[i].second - 1] != "W" &&
          !board[numbers[i].first][numbers[i].second - 1].isNumeric) {
        result[2] = true;
        break;
      }
    }
    // for (int i = 0; i < board.length; i++) {
    //   for (int j = 0; j < board[i].length; j++) {
    //     if (board[i][j].isNumeric &&
    //         j - 1 >= 0 &&
    //         board[i][j - 1] != "W" &&
    //         !board[i][j - 1].isNumeric) {
    //       print("Left hewe");
    //       ok = true;
    //       result[2] = true;
    //       break;
    //     }
    //     if (ok) break;
    //   }
    // }
    // ok = false;

    // Right
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].second + 1 < columns &&
          board[numbers[i].first][numbers[i].second + 1] != "W" &&
          !board[numbers[i].first][numbers[i].second + 1].isNumeric) {
        result[3] = true;
        break;
      }
    }
    // for (int i = 0; i < board.length; i++) {
    //   for (int j = 0; j < board[i].length; j++) {
    //     if (this.board[i][j].isNumeric &&
    //         j + 1 < this.columns &&
    //         this.board[i][j + 1] != "W" &&
    //         !this.board[i][j + 1].isNumeric) {
    //       print("Right here");
    //       ok = true;
    //       result[3] = true;
    //     }
    //   }
    //   if (ok) break;
    // }
    return result;
  }

  List<Structure> getNextState() {
    List<bool> moves = this.checkMoves();
    List<Structure> newStates = [];
    //Up
    if (moves[0]) {
      newStates.add(moveUp());
    } //down
    if (moves[1]) {
      newStates.add(moveDown());
    } //right
    if (moves[3]) {
      newStates.add(moveRight());
    } //left
    if (moves[2]) {
      newStates.add(moveLeft());
    }
    newStates.removeWhere((element) {
      return this.isEqual(element.board);
    });
    // print("Nextstates equal to ${newStates.length}");

    return newStates;
  }

  Structure moveUp() {
    Structure newStates = this.clone();
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].first - 1 >= 0 &&
          board[numbers[i].first - 1][numbers[i].second] != "W" &&
          !board[numbers[i].first - 1][numbers[i].second].isNumeric) {
        String temp = board[numbers[i].first][numbers[i].second];
        newStates.board[numbers[i].first][numbers[i].second] = "E";
        newStates.board[numbers[i].first - 1][numbers[i].second] = temp;
        newStates.numbers[i].first -= 1;
      }
    }

    // for (int i = 0; i < board.length; i++) {
    //   for (int j = 0; j < board[i].length; j++) {
    //     if (board[i][j].isNumeric &&
    //         i - 1 >= 0 &&
    //         board[i - 1][j] != "W" &&
    //         !board[i - 1][j].isNumeric) {
    //       print("UP here");
    //       String temp = board[i][j];
    //       newStates.board[i][j] = "E";
    //       newStates.board[i - 1][j] = temp;
    //     }
    //   }
    // }
    return newStates;
  }

  Structure moveDown() {
    Structure newStates = clone();
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].first + 1 < rows &&
          board[numbers[i].first + 1][numbers[i].second] != "W" &&
          !board[numbers[i].first + 1][numbers[i].second].isNumeric) {
        String temp = board[numbers[i].first][numbers[i].second];
        newStates.board[numbers[i].first][numbers[i].second] = "E";
        newStates.board[numbers[i].first + 1][numbers[i].second] = temp;
        newStates.numbers[i].first++;
      }
    }
    // for (int i = 0; i < board.length; i++) {
    //   for (int j = 0; j < board[i].length; j++) {
    //     if (board[i][j].isNumeric &&
    //         i + 1 < rows &&
    //         board[i + 1][j] != "W" &&
    //         !board[i + 1][j].isNumeric) {
    //       print("Down here");
    //       String temp = board[i][j];
    //       newStates.board[i][j] = "E";
    //       newStates.board[i + 1][j] = temp;
    //     }
    //   }
    // }
    return newStates;
  }

  Structure moveLeft() {
    Structure newStates = clone();
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].second - 1 >= 0 &&
          board[numbers[i].first][numbers[i].second - 1] != "W" &&
          !board[numbers[i].first][numbers[i].second - 1].isNumeric) {
        String temp = board[numbers[i].first][numbers[i].second];
        newStates.board[numbers[i].first][numbers[i].second] = "E";
        newStates.board[numbers[i].first][numbers[i].second - 1] = temp;
        newStates.numbers[i].second--;
      }
    }

    return newStates;
  }

  Structure moveRight() {
    Structure newStates = clone();
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].second + 1 < columns &&
          board[numbers[i].first][numbers[i].second + 1] != "W" &&
          !board[numbers[i].first][numbers[i].second + 1].isNumeric) {
        String temp = board[numbers[i].first][numbers[i].second];
        newStates.board[numbers[i].first][numbers[i].second] = "E";
        newStates.board[numbers[i].first][numbers[i].second + 1] = temp;
        newStates.numbers[i].second++;
      }
    }
    // for (int i = 0; i < board.length; i++) {
    //   for (int j = 0; j < board[i].length; j++) {
    //     if (this.board[i][j].isNumeric &&
    //         j + 1 < this.columns &&
    //         this.board[i][j + 1] != "W" &&
    //         !this.board[i][j + 1].isNumeric) {
    //       print("Right here");
    //       String temp = board[i][j].toString();
    //       newStates.board[i][j] = "E";
    //       newStates.board[i][j + 1] = temp;
    //       j++;
    //     }
    //   }
    // }
    return newStates;
  }

  Structure clone() {
    int rows = this.rows, columns = this.columns;
    List<List<String>> boardd = [];
    for (int i = 0; i < this.board.length; i++) {
      boardd.add([]);
      for (int j = 0; j < this.board[i].length; j++) {
        boardd[i].add(this.board[i][j]);
      }
    }
    List<Pair> num = [];
    for (var i = 0; i < this.numbers.length; i++) {
      num.add(new Pair(
          value: this.numbers[i].value,
          first: this.numbers[i].first,
          second: this.numbers[i].second));
    }
    return new Structure(
        rows: rows,
        columns: columns,
        board: boardd,
        perant: this,
        depth: this.depth + 1,
        goals: this.goals,
        numbers: num);
  }

  bool isEqual(List<List<String>> list) {
    return DeepCollectionEquality().equals(this.board, list);
  }

  bool isFinal() {
    // int cnt = 0;
    // print("finalllllllllllllllllllll $cnt");
    // for (int i = 0; i < numbers.length; i++) {
    //   print("${numbers[i].value}    ${goals[i].value}");
    //   print("${numbers[i].first}    ${goals[i].first}");
    //   print("${numbers[i].second}    ${goals[i].second}");
    // print("finalllllllllllllllllllll $cnt");
    //   for (int j = 0; j < goals.length; j++) {
    //     if (numbers[i].value == goals[j].value &&
    //         numbers[i].first == goals[j].first &&
    //         numbers[i].second == goals[j].second) {
    //       cnt++;
    //     }
    //   }
    // }
    // if (cnt == numbers.length) return true;
    // return false;

    for (int i = 0; i < this.board.length; i++) {
      for (int j = 0; j < this.board[i].length; j++) {
        if (this.board[i][j].isNumeric) {
          for (int k = 0; k < this.goals.length; k++) {
            if (this.goals[k].value == int.parse(this.board[i][j]) &&
                (this.goals[k].first != i || this.goals[k].second != j)) {
              return false;
            }
          }
        }
      }
    }
    return true;
  }

  int calculateHeuristic() {
    int heuristic = 0;

    for (var i in numbers) {
      for (var j in goals) {
        if (i.value == j.value) {
          print("value = ${i.value} ,  first = ${i.first}  ,  second= ${j.second}");
          print("value = ${j.value} ,  first = ${j.first}  ,  second= ${j.second}");
          heuristic +=
              ((i.first - j.first).abs() + (i.second - j.second).abs()).abs();

        }
      }
    }

    return heuristic;
  }
}

extension Numeric on String {
  bool get isNumeric => num.tryParse(this) != null ? true : false;
  // int get getNumber => num.parse(this) ;
}
