import 'dart:ffi';

import 'package:flutter/material.dart';
import 'DrawerFile.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'InstructionalVideo.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UnityWidgetController _unityWidgetController;
  String sceneName = "Scene Name: ";
  bool insButton = false;
  YoutubePlayerController _controller;
  Widget conte = Container(
    margin: const EdgeInsets.only(left: 50.00),
    height: 600,
    width: 300,
    // alignment: Alignment.center,
    // child: new InstructionalVideo(
    //     title: 'Youtube Demo Page',
    //     url: 'https://www.youtube.com/watch?v=bWidmwLKSo8'),
  );
  void sendUserInfo(String message) {
    _unityWidgetController.postMessage(
        'HomescreenController', 'getUserInfo', message);
  }

  void onUnityMessage(message) {
    setState(() {
      sceneName = "Scene Name: ${message.toString()}";
      if (message.toString() == 'Button on 1') {
        conte = Container(
          margin: const EdgeInsets.only(left: 5.00, right: 5.00),
          // height: 600,
          // width: 300,
          // alignment: Alignment.center,
          child: new InstructionalVideo(
              title: 'Youtube Demo Page',
              url: 'https://www.youtube.com/watch?v=s1aQgeKlpsY'),
        );
      }
      if (message.toString() == 'Button on 2') {
        conte = Container(
          margin: const EdgeInsets.only(left: 5.00, right: 5.00),
          child: new InstructionalVideo(
              title: 'Youtube Demo Page',
              url: 'https://www.youtube.com/watch?v=vZG2kaTacAY'),
        );
      }
      if (message.toString() == 'getUserInfo') {
        conte = Container(
          margin: const EdgeInsets.only(left: 5.00, right: 5.00),
        );
        sendUserInfo("Hello from flutter");
      } else if (message.toString() == 'Button off') {
        conte = Container(
          margin: const EdgeInsets.only(left: 40.00),
          height: 600,
          width: 300,
          alignment: Alignment.center,
        );
      }
    });
    print('Received message from unity: ${message.toString()}');
  }

  void onUnitySceneLoaded(SceneLoaded scene) {
    print('Received scene loaded from unity: ${scene.name}');
    print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('$sceneName'),
        ),
        drawer: MyDrawer(),
        body: Center(
            child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: UnityWidget(
                onUnityCreated: _onUnityCreated,
                onUnityMessage: onUnityMessage,
                onUnitySceneLoaded: onUnitySceneLoaded,
              ),
            ),
            conte,
          ],
        )));
  }
}
