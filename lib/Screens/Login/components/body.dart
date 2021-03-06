import 'package:flutter/material.dart';
import 'package:octopy/User.dart';
import '/Screens/Login/components/background.dart';
import '/Screens/Signup/signup_screen.dart';
import '/components/already_have_an_account_acheck.dart';
import '/components/rounded_button.dart';
import '/components/rounded_input_field.dart';
import '/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '/main.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _status = 'no-action';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/loginBackground.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) {
                user.username = value.toString().trim();
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                user.password = value.toString().trim();
              },
            ),
            RoundedButton(
              text: "Log In",
              press: () {
                // Navigator.of(context).pushReplacementNamed('/home');
                setState(() => this._status = 'loading');
                appAuth.verifyUser().then((result) {
                  if (result) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  } else {
                    setState(() => this._status = 'rejected');
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Invalid Login Credentials'),
                        content: const Text(
                            'Invalid Username and Password, Please Try Again'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Ok'),
                            child: const Text('Ok'),
                          ),
                        ],
                      ),
                    );
                  }
                });

                // appAuth.login().then((result) {
                //   if (result) {
                //     Navigator.of(context).pushReplacementNamed('/home');
                //   } else {
                //     setState(() => this._status = 'rejected');
                //     showDialog<String>(
                //       context: context,
                //       builder: (BuildContext context) => AlertDialog(
                //         title: const Text('Invalid Login Credentials'),
                //         content: const Text(
                //             'Invalid Username and Password, Please Try Again'),
                //         actions: <Widget>[
                //           TextButton(
                //             onPressed: () => Navigator.pop(context, 'Ok'),
                //             child: const Text('Ok'),
                //           ),
                //         ],
                //       ),
                //     );
                //   }
                // });
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
