import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '/DrawerFile.dart';

class DisplayVideo extends StatefulWidget {
  const DisplayVideo({Key key, this.title, this.url}) : super(key: key);

  final String title;
  final url;
  @override
  _DisplayVideoState createState() => _DisplayVideoState();
}

class _DisplayVideoState extends State<DisplayVideo> {
  YoutubePlayerController _controller;
  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
        flags: YoutubePlayerFlags(
          enableCaption: false,
          isLive: false,
          autoPlay: true,
        ));
    _controller.toggleFullScreenMode();
  }

  @override
  void initState() {
    runYoutubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
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
              '',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          drawer: MyDrawer(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              player,
              SizedBox(
                height: 40.0,
              ),
              Text(
                widget.title,
              )
            ],
          ),
        );
      },
    );
  }
}
