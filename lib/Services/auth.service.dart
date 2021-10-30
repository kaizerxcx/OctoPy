import 'dart:async';
import 'dart:math';
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
    http.Response response = await http.post(
        Uri.parse(
            "http://$server/api/verifyUser/${user.username}/${user.password}/"),
        body: {});
    session_id = int.parse(response.body);
    user.id = session_id;
    setUser(user.id);
    if (session_id > 0) {
      flag = true;
    }
  }
}
