import 'package:flutter/material.dart';
import 'package:octopy/Services/auth.service.dart';
import '/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '/main.dart';
import '/Services/auth.service.dart';
import '/GradientText.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String updateButtonState = "Update Profile";

  setButtonState(String state) {
    setState(() {
      updateButtonState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    var r = TextStyle(
        color: Color(0XFF57CBC8), fontSize: 34, fontWeight: FontWeight.bold);
    return new Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            decoration: BoxDecoration(
                // border: Border.all(width: 1, color: Colors.black38),
                // borderRadius: BorderRadius.circular(20),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 5,
                //     blurRadius: 7,
                //     offset: Offset(0, 3), // changes position of shadow
                //   ),
                // ],
                ),
            margin: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset('images/Trophy.png'),
            )),
        Expanded(
          child: Container(
            child: FutureBuilder(
              future: appAuth.getLeaderboard(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(child: Center(child: Text("Loading...")));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: EdgeInsets.all(2),
                        elevation: 2,
                        child: ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0XFFabe9cd),
                                    Color(0XFF3eadcf),
                                  ],
                                ),
                              ),
                              child: CircleAvatar(
                                  child: Text(
                                      '${snapshot.data[index].firstname[0]}${snapshot.data[index].lastname[0]}',
                                      style: TextStyle(color: Colors.white)),
                                  backgroundColor: Colors.transparent)),
                          // leading: Text(snapshot.data[index].position.toString()),
                          title: GradientText(
                            snapshot.data[index].username,
                            style: r,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0XFF63a4ff),
                                Color(0XFF83eaf1),
                              ],
                            ),
                          ),
                          trailing: Text(
                            index == 0
                                ? "🥇"
                                : index == 1
                                    ? "🥈"
                                    : index == 2
                                        ? "🥉".toString()
                                        : "",
                            style: r,
                          ),
                          subtitle: Text(snapshot.data[index].total.toString() +
                              " points"),
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     new MaterialPageRoute(
                            //         builder: (context) =>
                            //             DetailPage(snapshot.data[index])));
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        )
      ],
    ));
  }
}
