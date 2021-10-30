import 'package:flutter/material.dart';
import '/Screens/Profile/components/body.dart';
import '/DrawerFile.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      drawer: MyDrawer(),
      body: Body(),
    );
  }
}
