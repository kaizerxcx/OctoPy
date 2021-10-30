import 'package:flutter/material.dart';
import 'NewPage.dart';
import 'Home.dart';
import 'main.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
            accountName: Text('Ahmer Iqbal'),
            accountEmail: Text('ahmer5253@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: Text('JKT'),
              backgroundColor: Colors.white,
            ),
            otherAccountsPictures: [
              CircleAvatar(
                child: Text('A'),
                backgroundColor: Colors.white,
              )
            ],
            onDetailsPressed: () {},
          ),
          ListTile(
            leading: Icon(Icons.remove_red_eye),
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
            title: Text('Next Page'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NextPage()));
            },
            enabled: true,
            selected: true,
          ),
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
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () {
              print('Pressed');
            },
            enabled: false,
            // selected: true,
          ),
          Divider(thickness: 1.0),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
            onTap: () {
              print('Pressed');
            },
            enabled: false,
            // selected: true,
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payment Methods'),
            onTap: () {
              print('Pressed');
            },
            enabled: false,
            // selected: true,
          ),
          Divider(thickness: 1.0),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text('Bug'),
            onTap: () {
              print('Pressed');
            },
            enabled: false,
            // selected: true,
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
