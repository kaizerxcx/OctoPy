import 'dart:ffi';

import 'package:flutter/material.dart';
import 'DrawerFile.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'InstructionalVideo.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import '/Screens/Login/login_screen.dart';
import '/Services/auth.service.dart';

AuthService appAuth = new AuthService();

// void main() => runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: LoginScreen(),
//     ));
void main() async {
  // Set default home.
  Widget _defaultHome = new LoginScreen();

  // Get result of the login function.
  bool _result = await appAuth.login();
  if (_result) {
    _defaultHome = new HomePage();
  }

  // Run app!
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blue),
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(),
      '/login': (BuildContext context) => new LoginScreen()
    },
  ));
}
