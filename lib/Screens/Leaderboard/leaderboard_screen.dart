import 'package:flutter/material.dart';
import 'package:octopy/constants.dart';
import '/Screens/Leaderboard/components/body.dart';
import '/DrawerFile.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0XFF57CBC8),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0XFFabe9cd),
              Color(0XFF3eadcf),
            ],
          )),
        ),
        title: Text(
          'Score Leaderboards',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(),
      body: Body(),
    );
  }
}
