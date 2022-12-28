import 'package:flutter/material.dart';
import 'package:home_work_1/structure/structure_main.dart';
import 'package:home_work_1/ui/dfs_screen.dart';
import 'package:home_work_1/ui/levels_screen.dart';
import 'package:home_work_1/ui/play_screen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: DFSScreen(),
      home: LevelsScreen(),
    );
  }
}
