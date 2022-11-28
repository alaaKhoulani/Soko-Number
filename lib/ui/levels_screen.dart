import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_work_1/constants/levels.dart';
import 'package:home_work_1/ui/play_screen.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Colors.grey,
      //   title: Text(
      //       "Soko Number",
      //       style: TextStyle(color: Colors.purple, fontSize: 30,fontWeight: FontWeight.bold),
      //     ),
      // ),
      backgroundColor: Colors.grey,
      body: SafeArea(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
          Text(
            "Soko Number",
            style: TextStyle(color: Colors.purple, fontSize: 30,fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 100,
          ),
          // Text("Levels:",style: TextStyle(color: Colors.red,fontSize: 30),textAlign: TextAlign.left,),

          GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => PlayingScreen(
                          currentLevel: levels[index],
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Level ${index + 1}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.purple, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                );
              }),
        ],
      )),
    );
  }
}
