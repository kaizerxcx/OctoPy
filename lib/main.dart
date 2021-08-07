import 'package:flutter/material.dart';
import 'DrawerFile.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

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

  void onUnityMessage(message) {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: Text('OctoPy'),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: UnityWidget(
          onUnityCreated: _onUnityCreated,
          onUnityMessage: onUnityMessage,
          onUnitySceneLoaded: onUnitySceneLoaded,
        ),
      ),
    );
  }
}
