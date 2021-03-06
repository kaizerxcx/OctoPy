import 'package:flutter/material.dart';
import 'package:octopy/constants.dart';
import '/Screens/Profile/components/body.dart';
import '/DrawerFile.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.white),
        ),
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
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          // canvasColor:
          //     Colors.pink, //This will change the drawer background to blue.
          // //other styles
          primaryColor: Color(0XFF57CBC8),
        ),
        child: MyDrawer(),
      ),
      body: Body(),
    );
  }
}
