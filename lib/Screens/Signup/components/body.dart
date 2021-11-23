import 'package:flutter/material.dart';
import 'package:octopy/Services/auth.service.dart';
import '/Screens/Login/login_screen.dart';
import '/Screens/Signup/components/background.dart';
import '/Screens/Signup/components/or_divider.dart';
import '/Screens/Signup/components/social_icon.dart';
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
  String registerButtonState = "Sign Up";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String usernameValidator;
  String emailValidator;
  setButtonState(String state) {
    setState(() {
      registerButtonState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                RoundedInputField(
                  hintText: "Firstname",
                  isName: true,
                  check: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    user.firstname = value.toString().trim();
                  },
                ),
                RoundedInputField(
                  hintText: "Lastname",
                  isName: true,
                  check: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    user.lastname = value.toString().trim();
                  },
                ),
                RoundedInputAgeField(
                  icon: Icons.cake,
                  hintText: "Age (6-8 only)",
                  check: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Age';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    user.age = int.parse(value.toString().trim());
                  },
                ),
                RoundedInputField(
                  icon: Icons.account_circle,
                  hintText: "Username",
                  check: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return usernameValidator;
                  },
                  onChanged: (value) {
                    user.username = value.toString().trim();
                  },
                ),
                RoundedInputField(
                  icon: Icons.email,
                  hintText: "Email",
                  check: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Invalid email';
                    }
                    return emailValidator;
                  },
                  onChanged: (value) {
                    user.email = value.toString().trim();
                  },
                ),
                RoundedPasswordField(
                  check: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}")
                        .hasMatch(value)) {
                      return 'minimum of 8 characters, 1 letter & 1 number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    user.password = value.toString().trim();
                  },
                ),
                RoundedButton(
                  text: registerButtonState,
                  press: () async {
                    var responseUsername =
                        await appAuth.checkUsername(user.username);
                    setState(() {
                      if (responseUsername == 1) {
                        this.usernameValidator = "Username Already Exists";
                      } else
                        this.usernameValidator = null;
                    });

                    var responseEmail = await appAuth.checkEmail(user.email);
                    setState(() {
                      if (responseEmail == 1) {
                        this.emailValidator = "Email Address Already Exists";
                      } else
                        this.emailValidator = null;
                    });

                    if (_formKey.currentState.validate()) {
                      setButtonState("Processing..");
                      appAuth
                          .regiterUser(user.firstname, user.lastname, user.age,
                              user.username, user.email, user.password)
                          .then((result) {
                        // setButtonState("Success");
                        setButtonState("Sign Up");
                        appAuth.logout().then((_) => Navigator.of(context)
                            .pushReplacementNamed('/login'));
                      });
                    }
                  },
                ),
                // SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}






// @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Background(
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(20),
//             ),
//             Text(
//               "Sign Up",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//             ),
//             RoundedInputField(
//               hintText: "Firstname",
//               isName: true,
//               onChanged: (value) {
//                 user.firstname = value.toString().trim();
//               },
//             ),
//             RoundedInputField(
//               hintText: "Lastname",
//               isName: true,
//               onChanged: (value) {
//                 user.lastname = value.toString().trim();
//               },
//             ),
//             RoundedInputAgeField(
//               icon: Icons.cake,
//               hintText: "Age (6-8 only)",
//               onChanged: (value) {
//                 user.age = int.parse(value.toString().trim());
//               },
//             ),
//             RoundedInputField(
//               icon: Icons.account_circle,
//               hintText: "Username",
//               check: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 user.username = value.toString().trim();
//               },
//             ),
//             RoundedPasswordField(
//               onChanged: (value) {
//                 user.password = value.toString().trim();
//               },
//             ),
//             RoundedButton(
//               text: registerButtonState,
//               press: () {
//                 if (!_formKey.currentState.validate()) {
//                   setButtonState("Processing..");
//                   appAuth
//                       .regiterUser(user.firstname, user.lastname, user.age,
//                           user.username, user.password)
//                       .then((result) {
//                     // setButtonState("Success");
//                     setButtonState("Sign Up");
//                     appAuth.logout().then((_) =>
//                         Navigator.of(context).pushReplacementNamed('/login'));
//                   });
//                 }
//               },
//             ),
//             SizedBox(height: size.height * 0.03),
//             AlreadyHaveAnAccountCheck(
//               login: false,
//               press: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return LoginScreen();
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }