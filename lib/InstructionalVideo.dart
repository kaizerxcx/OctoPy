import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// enum DialogAction { yes, abort }

// class Dialogs {
//   static Future<DialogAction> yesAbortDialog(
//     BuildContext context,
//     String title,
//     String body,
//   ) async {
//     final action = await showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           title: Text(title),
//           content: InstructionalVideo(
//               title: "Youtube",
//               url: 'https://www.youtube.com/watch?v=bWidmwLKSo8'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(DialogAction.abort),
//               child: const Text('No'),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(DialogAction.yes),
//               child: const Text(
//                 'Yes',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     return (action != null) ? action : DialogAction.abort;
//   }
// }

class InstructionalVideo extends StatefulWidget {
  const InstructionalVideo({Key key, this.title, this.url, this.play = false})
      : super(key: key);

  final String title;
  final url;
  final bool play;
  @override
  _InstructionalVideoState createState() => _InstructionalVideoState();
}

class _InstructionalVideoState extends State<InstructionalVideo> {
  YoutubePlayerController _controller;
  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
        flags: YoutubePlayerFlags(
          enableCaption: false,
          isLive: false,
          autoPlay: widget.play,
        ));
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

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            player,
            SizedBox(
              height: 40.0,
            ),
            // Text(
            //   'Youtube Player',
            // )
          ],
        );
      },
    );
  }
}
