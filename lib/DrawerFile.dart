import 'package:flutter/material.dart';
import 'NewPage.dart';
import 'Home.dart';
import 'main.dart';
import '/Screens/Profile/profile_screen.dart';
import '/Screens/Leaderboard/leaderboard_screen.dart';
import 'Screens/Reward/reward_screen.dart';
import 'Screens/Insights/insight_screen.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String firstname = "Loading";
  String lastname = "Loading";
  String username = "Loading";

  void setFirstname(String fname) {
    setState(() {
      firstname = fname;
    });
  }

  void setLastname(String lname) {
    setState(() {
      lastname = lname;
    });
  }

  void setUsername(String username) {
    setState(() {
      this.username = username;
    });
  }

  void initState() {
    super.initState();
    appAuth.getUser(user.id).then((result) {
      user.firstname = result[0]['firstname'];
      user.lastname = result[0]['lastname'];
      user.age = result[0]['age'];
      user.username = result[0]['username'];
      user.email = result[0]['email'];
      setFirstname(result[0]['firstname']);
      setLastname(result[0]['lastname']);
      setUsername(result[0]['username']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // DrawerHeader(child: Text('Ahmer')),
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              // gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
              color: Color(0XFF57CBC8),
              // image: DecorationImage(
              //     image: AssetImage('images/background.jpg'),
              //     fit: BoxFit.cover),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                stops: [0, 0.74],
                colors: [
                  Color(0XFFabe9cd),
                  Color(0XFF3eadcf),
                ],
              ),
            ),
            accountName: Text(
              "$firstname, $lastname",
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              username,
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              child: Text(
                "${firstname[0]}${lastname[0]}",
                style: TextStyle(color: Color(0XFF57CBC8)),
              ),
              backgroundColor: Colors.white,
            ),
            otherAccountsPictures: [
              CircleAvatar(
                child: Text(
                  "${firstname[0]}${lastname[0]}",
                  style: TextStyle(color: Color(0XFF57CBC8)),
                ),
                backgroundColor: Colors.white,
              )
            ],
            onDetailsPressed: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Color(0XFF57CBC8),
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Color(0XFF57CBC8)),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            // enabled: false,
            selected: true,
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Color(0XFF57CBC8),
            ),
            title: Text(
              'My Profile',
              style: TextStyle(color: Color(0XFF57CBC8)),
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                  (route) => false);
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            enabled: true,
            selected: true,
          ),
          ListTile(
            leading: Icon(
              Icons.bar_chart,
              color: Color(0XFF57CBC8),
            ),
            title: Text(
              'Leaderboards',
              style: TextStyle(color: Color(0XFF57CBC8)),
            ),
            onTap: () {
              appAuth.getLeaderboard();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                  (route) => false);
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => LeaderboardScreen()));
            },
            enabled: true,
            selected: true,
          ),
          ListTile(
            leading: Icon(
              Icons.money,
              color: Color(0XFF57CBC8),
            ),
            title: Text(
              'My Rewards',
              style: TextStyle(color: Color(0XFF57CBC8)),
            ),
            onTap: () {
              // appAuth.getUser(user.id).then((result) {
              //   print(result);
              // });
              // print(appAuth.dogs[0]['name']);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => RewardScreen()),
                  (route) => false);
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => RewardScreen()));
            },
            enabled: true,
            selected: true,
          ),
          ListTile(
            leading: Icon(
              Icons.stacked_line_chart,
              color: Color(0XFF57CBC8),
            ),
            title: Text(
              'Insights',
              style: TextStyle(color: Color(0XFF57CBC8)),
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => InsightScreen()),
                  (route) => false);
            },
            enabled: true,
            selected: true,
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Color(0XFF57CBC8),
            ),
            title: Text(
              'Next Page',
              style: TextStyle(color: Color(0XFF57CBC8)),
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => NextPage()),
                  (route) => false);
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => NextPage()));
            },
            enabled: false,
            selected: false,
          ),
          Divider(thickness: 1.0),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Color(0XFF57CBC8),
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Color(0XFF57CBC8)),
            ),
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Sign Out of App?'),
                  content: const Text('Are you sure that you to Sign Out'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        appAuth.setUser(-1);
                        appAuth.logout().then((_) => Navigator.of(context)
                            .pushReplacementNamed('/login'));
                      },
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              );
            },
            enabled: true,
            selected: true,
          ),
          Divider(thickness: 1.0),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: Icon(
                  Icons.close,
                  color: Color(0XFF57CBC8),
                ),
                title: Text(
                  'Close',
                  style: TextStyle(color: Color(0XFF57CBC8)),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  print('Pressed');
                },
                // enabled: false,
                selected: true,
              ),
            ),
          )
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       //other scaffold items
  //       drawer: Theme(
  //     data: Theme.of(context).copyWith(
  //       canvasColor:
  //           Colors.pink, //This will change the drawer background to blue.
  //       //other styles
  //     ),
  //     child: Drawer(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.max,
  //         children: [
  //           // DrawerHeader(child: Text('Ahmer')),
  //           UserAccountsDrawerHeader(
  //             decoration: BoxDecoration(
  //               // gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
  //               color: Color(0XFF57CBC8),
  //               image: DecorationImage(
  //                   image: AssetImage('images/background.jpg'),
  //                   fit: BoxFit.cover),
  //             ),
  //             accountName: Text("$firstname, $lastname"),
  //             accountEmail: Text(username),
  //             currentAccountPicture: CircleAvatar(
  //               child: Text("${firstname[0]}${lastname[0]}"),
  //               backgroundColor: Colors.white,
  //             ),
  //             otherAccountsPictures: [
  //               CircleAvatar(
  //                 child: Text("${firstname[0]}${lastname[0]}"),
  //                 backgroundColor: Colors.white,
  //               )
  //             ],
  //             onDetailsPressed: () {},
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.home),
  //             title: Text('Home'),
  //             onTap: () {
  //               Navigator.of(context)
  //                   .push(MaterialPageRoute(builder: (context) => HomePage()));
  //             },
  //             // enabled: false,
  //             selected: true,
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.account_circle),
  //             title: Text('My Profile'),
  //             onTap: () {
  //               Navigator.of(context).push(
  //                   MaterialPageRoute(builder: (context) => ProfileScreen()));
  //             },
  //             enabled: true,
  //             selected: true,
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.bar_chart),
  //             title: Text('Leaderboards'),
  //             onTap: () {
  //               // appAuth.getUser(user.id).then((result) {
  //               //   print(result);
  //               // });
  //               // print(appAuth.dogs[0]['name']);
  //             },
  //             enabled: true,
  //             selected: true,
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.money),
  //             title: Text('My Rewards'),
  //             onTap: () {
  //               // appAuth.getUser(user.id).then((result) {
  //               //   print(result);
  //               // });
  //               // print(appAuth.dogs[0]['name']);
  //             },
  //             enabled: true,
  //             selected: true,
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.stacked_line_chart),
  //             title: Text('Insights'),
  //             onTap: () {
  //               print('Pressed');
  //             },
  //             enabled: false,
  //             selected: true,
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.account_circle),
  //             title: Text('Next Page'),
  //             onTap: () {
  //               Navigator.of(context)
  //                   .push(MaterialPageRoute(builder: (context) => NextPage()));
  //             },
  //             enabled: false,
  //             selected: false,
  //           ),
  //           Divider(thickness: 1.0),
  //           ListTile(
  //             leading: Icon(Icons.exit_to_app),
  //             title: Text('Logout'),
  //             onTap: () {
  //               showDialog<String>(
  //                 context: context,
  //                 builder: (BuildContext context) => AlertDialog(
  //                   title: const Text('Sign Out of App?'),
  //                   content: const Text('Are you sure that you to Sign Out'),
  //                   actions: <Widget>[
  //                     TextButton(
  //                       onPressed: () => Navigator.pop(context, 'Cancel'),
  //                       child: const Text('Cancel'),
  //                     ),
  //                     TextButton(
  //                       onPressed: () {
  //                         appAuth.setUser(-1);
  //                         appAuth.logout().then((_) => Navigator.of(context)
  //                             .pushReplacementNamed('/login'));
  //                       },
  //                       child: const Text('Sign Out'),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             },
  //             enabled: true,
  //             selected: true,
  //           ),
  //           Divider(thickness: 1.0),
  //           Expanded(
  //             child: Align(
  //               alignment: Alignment.bottomCenter,
  //               child: ListTile(
  //                 leading: Icon(Icons.close),
  //                 title: Text('Close'),
  //                 onTap: () {
  //                   Navigator.of(context).pop();
  //                   print('Pressed');
  //                 },
  //                 // enabled: false,
  //                 selected: true,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   ));
  // }
}
