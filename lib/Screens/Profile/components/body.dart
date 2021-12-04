import 'package:flutter/material.dart';
import 'package:octopy/Services/auth.service.dart';
import '/Screens/Login/login_screen.dart';
import '/Screens/Profile/components/background.dart';
import '/Screens/Profile/components/or_divider.dart';
import '/Screens/Profile/components/social_icon.dart';
import '/components/already_have_an_account_acheck.dart';
import '/components/rounded_button.dart';
import '/components/rounded_input_field.dart';
import '/components/rounded_input_age_field.dart';
import '/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '/main.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String updateButtonState = "Update Profile";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  setButtonState(String state) {
    setState(() {
      updateButtonState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(1),
                ),
                RoundedInputField(
                  text: user.firstname,
                  isName: true,
                  check: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    user.firstname = value.toString();
                  },
                ),
                RoundedInputField(
                  text: user.lastname,
                  isName: true,
                  check: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    user.lastname = value.toString();
                  },
                ),
                RoundedInputAgeField(
                  icon: Icons.cake,
                  text: user.age.toString(),
                  check: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    user.age = int.parse(value.toString().trim());
                  },
                ),
                RoundedInputField(
                  icon: Icons.account_circle,
                  text: user.username,
                  check: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    user.username = value.toString().trim();
                  },
                ),
                RoundedInputField(
                  icon: Icons.email,
                  text: user.email,
                  check: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Age';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    user.email = value.toString().trim();
                  },
                ),
                RoundedPasswordField(
                  display: 'New Password',
                  onChanged: (value) {
                    user.password = value.toString().trim();
                  },
                ),
                RoundedButton(
                  text: updateButtonState,
                  press: () {
                    if (_formKey.currentState.validate()) {
                      setButtonState("Processing..");
                      appAuth
                          .updateUser(
                              user.id,
                              user.firstname,
                              user.lastname,
                              user.age,
                              user.username,
                              user.email,
                              user.password)
                          .then((result) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: const Text('Profile Successfully Updated'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                        setButtonState("Update Profile");
                      });
                    }
                  },
                ),
                RoundedButton(
                  color: Colors.red,
                  text: 'Delete Account',
                  press: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Delete Account'),
                        content: const Text(
                            'Are you sure you want to delete your account?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'Cancel');
                              appAuth.deleteUser(user.id).then((result) {});
                              appAuth.setUser(-1);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => false);
                              appAuth.logout().then((_) => Navigator.of(context)
                                  .pushReplacementNamed('/login'));
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
