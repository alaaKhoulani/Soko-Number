// import 'package:home_work_1/structure/structure_main.dart';

import 'package:home_work_1/constants/pair.dart';
import 'package:home_work_1/structure/structure_main.dart';

Structure level1 = new Structure(
    rows: 3,
    columns: 7,
    depth: 0,
    board: [
      ["W", "W", "W", "W", "W", "W", "W"],
      ["W", "1", "E", "E", "E", "E", "W"],
      ["W", "W", "W", "W", "W", "W", "W"],
    ],
    goals: [Pair(value: 1, first: 1, second: 5)],
    numbers: [Pair(value: 1, first: 1, second: 1)],
    perant: null);
Structure level2 = Structure(
    rows: 7,
    columns: 5,
    depth: 0,
    board: [
      ["W", "W", "W", "W", "W"],
      ["W", "1", "W", "2", "W"],
      ["W", "E", "W", "E", "W"],
      ["W", "E", "W", "E", "W"],
      ["W", "E", "W", "E", "W"],
      ["W", "E", "W", "E", "W"],
      ["W", "W", "W", "W", "W"],
    ],
    goals: [
      Pair(value: 1, first: 5, second: 1),
      Pair(value: 2, first: 5, second: 3),
    ],
    numbers: [
      Pair(value: 1, first: 1, second: 1),
      Pair(value: 2, first: 1, second: 3),
    ],
    perant: null);
Structure level3 = Structure(
    rows: 5,
    columns: 5,
    depth: 0,
    board: [
      ["W", "W", "W", "W", "W"],
      ["W", "1", "E", "E", "W"],
      ["W", "W", "E", "W", "W"],
      ["W", "E", "E", "2", "W"],
      ["W", "W", "W", "W", "W"],
    ],
    goals: [
      Pair(value: 1, first: 3, second: 2),
      Pair(value: 2, first: 1, second: 2),
    ],
    numbers: [
      Pair(value: 1, first: 1, second: 1),
      Pair(value: 2, first: 3, second: 3)
    ],
    perant: null);
Structure level4 = Structure(
    rows: 5,
    columns: 7,
    depth: 0,
    board: [
      ["W", "W", "W", "W", "W", "W", "W"],
      ["W", "1", "W", "2", "W", "3", "W"],
      ["W", "E", "E", "E", "E", "E", "W"],
      ["W", "W", "W", "E", "W", "W", "W"],
      ["W", "W", "W", "W", "W", "W", "W"],
    ],
    goals: [
      Pair(value: 1, first: 2, second: 5),
      Pair(value: 2, first: 2, second: 3),
      Pair(value: 3, first: 2, second: 1),
    ],
    numbers: [
      Pair(value: 1, first: 1, second: 1),
      Pair(value: 2, first: 1, second: 3),
      Pair(value: 3, first: 1, second: 5),
    ],
    perant: null);
Structure level5 = Structure(
    rows: 6,
    columns: 6,
    depth: 0,
    board: [
      ["W", "W", "W", "W", "W", "W"],
      ["W", "1", "W", "W", "W", "W"],
      ["W", "E", "2", "W", "E", "W"],
      ["W", "E", "E", "3", "E", "W"],
      ["W", "E", "E", "E", "4", "W"],
      ["W", "W", "W", "W", "W", "W"],
    ],
    goals: [
      Pair(value: 1, first: 2, second: 1),
      Pair(value: 2, first: 3, second: 2),
      Pair(value: 3, first: 4, second: 3),
      Pair(value: 4, first: 3, second: 4),
    ],
    numbers: [
      Pair(value: 1, first: 1, second: 1),
      Pair(value: 2, first: 2, second: 2),
      Pair(value: 3, first: 3, second: 3),
      Pair(value: 4, first: 4, second: 4),
    ],
    perant: null);
Structure level6 = Structure(
    rows: 5,
    columns: 6,
    depth: 0,
    board: [
      ["W", "W", "W", "W", "W", "W"],
      ["W", "E", "E", "2", "W", "W"],
      ["W", "E", "1", "E", "5", "W"],
      ["W", "3", "W", "4", "E", "W"],
      ["W", "W", "W", "W", "W", "W"],
    ],
    goals: [
      Pair(value: 1, first: 2, second: 3),
      Pair(value: 2, first: 1, second: 3),
      Pair(value: 3, first: 3, second: 3),
      Pair(value: 4, first: 3, second: 4),
      Pair(value: 5, first: 2, second: 4),
    ],
    numbers: [
      Pair(value: 1, first: 2, second: 2),
      Pair(value: 2, first: 1, second: 3),
      Pair(value: 3, first: 3, second: 1),
      Pair(value: 4, first: 3, second: 3),
      Pair(value: 5, first: 2, second: 4),
    ],
    perant: null);

List<Structure> levels = [level1, level2, level3, level4, level5, level6];
