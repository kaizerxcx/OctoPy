import 'dart:async';
import 'dart:math';
import 'package:octopy/User.dart';

import '/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String server = "10.0.2.2:8000";
  int session_id = -1;
  bool flag = false;
  // Login
  Future<bool> login() async {
    isLogin('user_id').then((result) {
      session_id = result;
      if (result > 0) {
        flag = true;
        user.id = result;
      }
      print(result);
    });
    //   http.Response response = await http.post(
    // Uri.parse("https://api.instagram.com/oauth/access_token"),
    // body: {
    //   "client_id": clientID,
    //   "redirect_uri": redirectUri,
    //   "client_secret": appSecret,
    //   "code": authorizationCode,
    //   "grant_type": "authorization_code",
    // });

    // http.Response response = await http
    //     .get(Uri.parse("https://jsonplaceholder.typicode.com/todos/"));
    // var data = json.decode(response.body);
    // print(data[0]['id']);

    // http.Response response = await http.post(
    //     Uri.parse(
    //         "http://$server/api/verifyUser/${user.username}/${user.password}/"),
    //     body: {});
    // session_id = int.parse(response.body);
    // user.id = session_id;
    // setUser(user.id);
    // if (session_id > 0) {
    //   flag = true;
    // }
    // Simulate a future for response after 2 second.
    return await new Future<bool>.delayed(
        // new Duration(seconds: 2), () => new Random().nextBool());
        new Duration(seconds: 1),
        () => flag);
  }

  // Logout
  Future<void> logout() async {
    // Simulate a future for response after 1 second.
    return await new Future<void>.delayed(new Duration(seconds: 1));
  }

  setUser(int user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user_id);
  }

  Future<int> isLogin(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getInt(key) ?? -1;
  }

  verifyUser() async {
    bool ff = false;
    http.Response response = await http.post(
        Uri.parse(
            "http://$server/api/verifyUser/${user.username}/${user.password}/"),
        body: {});
    session_id = int.parse(response.body);
    user.id = int.parse(response.body);
    print(int.parse(response.body));
    setUser(user.id);
    if (session_id > 0) {
      flag = true;
      ff = true;
    }
    return ff;
  }

  regiterUser(String firstname, String lastname, int age, String username,
      String password) async {
    http.Response response = await http.post(
        Uri.parse(
            "http://$server/api/registerUser/$firstname/$lastname/$age/$username/$password/"),
        body: {});
    // return firstname;
  }

  getUser(int user_id) async {
    http.Response response = await http
        .post(Uri.parse("http://$server/api/getUser/$user_id/"), body: {});

    var data = json.decode(response.body);
    // user.firstname = data[0]['firstname'];
    // user.lastname = data[0]['lastname'];
    // user.username = data[0]['username'];
    // print(data.runtimeType);
    return data;
  }

  updateUser(int user_id, String firstname, String lastname, int age,
      String username, String password) async {
    http.Response response = await http.post(
        Uri.parse(
            "http://$server/api/updateUser/$user_id/$firstname/$lastname/$age/$username/$password/"),
        body: {});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return true;
    }
  }

  deleteUser(int user_id) async {
    http.Response response = await http
        .post(Uri.parse("http://$server/api/deleteUser/$user_id/"), body: {});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return true;
    }
  }
}
