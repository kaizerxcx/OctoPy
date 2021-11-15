import 'package:flutter/material.dart';
import 'package:octopy/Services/auth.service.dart';
import '/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '/main.dart';
import '/Services/auth.service.dart';
import '/GradientText.dart';
import '/VideoOutput.dart';
import '/SimpleBarChart.dart';
import '/Child.dart';

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
  var map = {
    "Phonics": 0.0,
    "Phonemes": 0.0,
    "Vocabulary": 0.0,
    "Instruction": 0.0,
    "Reading": 0.0
  };

  List<UserInsights> data = [];

  void initState() {
    super.initState();
    for (var key in map.keys) {
      UserInsights user = new UserInsights(key, map[key]);
      data.add(user);
    }
    populateData();
  }

  populateData() async {
    var response = await appAuth.getChartData(user.id);
    data.clear();
    setState(() {
      for (var key in response.keys) {
        UserInsights user = new UserInsights(key, response[key]);
        data.add(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: Container(
                decoration: BoxDecoration(),
                margin: const EdgeInsets.all(4),
                child: SimpleBarChart.withSampleData(data))),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(),
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            "Recommended Learning",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Container(
            child: FutureBuilder(
              future: appAuth.getLearning(user.id),
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
