import 'package:flutter/material.dart';
import 'NewPage.dart';
import 'Home.dart';
import 'main.dart';
import '/Screens/Profile/profile_screen.dart';

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
              color: Colors.blue,
              image: DecorationImage(
                  image: AssetImage('images/background.jpg'),
                  fit: BoxFit.cover),
            ),
            accountName: Text("$firstname, $lastname"),
            accountEmail: Text(username),
            currentAccountPicture: CircleAvatar(
              child: Text("${firstname[0]}${lastname[0]}"),
              backgroundColor: Colors.white,
            ),
            otherAccountsPictures: [
              CircleAvatar(
                child: Text("${firstname[0]}${lastname[0]}"),
                backgroundColor: Colors.white,
              )
            ],
            onDetailsPressed: () {},
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            // enabled: false,
            selected: true,
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My Profile'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            enabled: true,
            selected: true,
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Leaderboards'),
            onTap: () {
              // appAuth.getUser(user.id).then((result) {
              //   print(result);
              // });
              // print(appAuth.dogs[0]['name']);
            },
            enabled: true,
            selected: true,
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('My Rewards'),
            onTap: () {
              // appAuth.getUser(user.id).then((result) {
              //   print(result);
              // });
              // print(appAuth.dogs[0]['name']);
            },
            enabled: true,
            selected: true,
          ),
          ListTile(
            leading: Icon(Icons.stacked_line_chart),
            title: Text('Insights'),
            onTap: () {
              print('Pressed');
            },
            enabled: false,
            selected: true,
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Next Page'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NextPage()));
            },
            enabled: false,
            selected: false,
          ),
          Divider(thickness: 1.0),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
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
                leading: Icon(Icons.close),
                title: Text('Close'),
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
}
