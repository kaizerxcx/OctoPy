import 'package:flutter/material.dart';
import 'package:octopy/constants.dart';
import '/Screens/Insights/components/body.dart';
import '/DrawerFile.dart';

class InsightScreen extends StatelessWidget {
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
          'Insights',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(),
      body: Body(),
    );
  }
}
