import 'package:flutter/material.dart';
import 'package:octopy/Services/auth.service.dart';
import '/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '/main.dart';
import '/Services/auth.service.dart';
import '/GradientText.dart';
import '/VideoOutput.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key key,
    this.thumbnail,
    this.title,
    this.user,
    this.date,
    this.press,
  }) : super(key: key);
  final Function press;
  final Widget thumbnail;
  final String title;
  final String user;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: GestureDetector(
          onTap: press,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: thumbnail,
              ),
              Expanded(
                flex: 3,
                child: _VideoDescription(
                  title: title,
                  user: user,
                  date: date,
                ),
              ),
              const Icon(
                Icons.more_vert,
                size: 16.0,
              ),
            ],
          ),
        ));
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    Key key,
    this.title,
    this.user,
    this.date,
  }) : super(key: key);

  final String title;
  final String user;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            user,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$date',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Uri myUri = Uri.parse("http://stackoverflow.com");
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            decoration: BoxDecoration(),
            margin: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset('images/Trophy.png'),
            )),
        Expanded(
          child: Container(
            child: FutureBuilder(
              future: appAuth.getReward(user.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data.length);
                if (snapshot.data == null) {
                  return Container(child: Center(child: Text("Loading...")));
                } else {
                  return ListView(
                    padding: const EdgeInsets.all(8.0),
                    itemExtent: 106.0,
                    children: [
                      for (int i = 0; i < snapshot.data.length; i++)
                        CustomListItem(
                          user: "${snapshot.data[i]['username']}",
                          date: "${snapshot.data[i]['date']}",
                          thumbnail: Image(
                            image: "${snapshot.data[i]['thum']}" != null
                                ? NetworkImage("${snapshot.data[i]['thum']}")
                                : null,
                          ),
                          title: "${snapshot.data[i]['title']}",
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DisplayVideo(
                                      title: "${snapshot.data[i]['title']}",
                                      url: "${snapshot.data[i]['url']}",
                                    )));
                          },
                        ),
                    ],
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}




//  Expanded(
//             child: Container(
//           child: ListView(
//             padding: const EdgeInsets.all(8.0),
//             itemExtent: 106.0,
//             children: <CustomListItem>[
//               CustomListItem(
//                 user: username,
//                 date: date,
//                 thumbnail: Container(
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: NetworkImage(
//                               "https://img.youtube.com/vi/moKn3gL1OQ0/0.jpg"),
//                           fit: BoxFit.cover)),
//                 ),
//                 title: title,
//                 press: () {
//                   print("pislit");
//                 },
//               ),
//               // CustomListItem(
//               //   user: 'Dash',
//               //   viewCount: 884000,
//               //   thumbnail: Container(
//               //     decoration: const BoxDecoration(color: Colors.yellow),
//               //   ),
//               //   title: 'Announcing Flutter 1.0',
//               // ),
//             ],
//           ),
//         ))