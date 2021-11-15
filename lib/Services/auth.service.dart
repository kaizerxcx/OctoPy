import 'dart:async';
import 'dart:math';
import 'package:octopy/User.dart';

import '/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '/Child.dart';

class AuthService {
  String server = "10.0.2.2:8000";
  // String server = "192.168.137.1:8000";
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
      String email, String password) async {
    http.Response response = await http.post(
        Uri.parse(
            "http://$server/api/registerUser/$firstname/$lastname/$age/$username/$email/$password/"),
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
      String username, String email, String password) async {
    http.Response response = await http.post(
        Uri.parse(
            "http://$server/api/updateUser/$user_id/$firstname/$lastname/$age/$username/$email/$password/"),
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

  Future<List<Child>> getLeaderboard() async {
    http.Response response =
        await http.get(Uri.parse("http://$server/api/getLeaderboard/"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = json.decode(response.body);
      jsonData = json.decode(jsonData);
      List<Child> users = [];
      // print(jsonData[0]);
      for (var u in jsonData) {
        Child user = Child.named(
            u['firstname'],
            u['lastname'],
            u['username'],
            u['crazeOnPhonicPoints'],
            u['wordKitPoints'],
            u['alphaHopperPoints'],
            u['mazeCrazePoints'],
            u['readingSpreePoints'],
            u['total'],
            u['position']);

        users.add(user);
      }

      print(users.length);
      return users;
    }
  }

  getReward(int user_id) async {
    http.Response response =
        await http.post(Uri.parse("http://$server/api/getReward/$user_id/"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = json.decode(response.body);
      jsonData = json.decode(jsonData);
      List result = [];
      if (jsonData[0]['position'] == 1.0) {
        var map1 = {
          'username': "Cocomelon - Nursery Rhymes",
          'title': "Halloween Dress Up Song  CoComelon",
          'date': "Oct 23, 2021",
          'thum': "https://img.youtube.com/vi/moKn3gL1OQ0/0.jpg",
          'url': "https://www.youtube.com/watch?v=moKn3gL1OQ0",
        };
        result.add(map1);
      } else if (jsonData[0]['position'] == 2.0) {
        var map2 = {
          'username': "Hello Kitty and Friends",
          'title':
              "My Melody's Top 5 Episodes | Hello Kitty and Friends Supercute Adventures",
          'date': "Aug 22, 2021",
          'thum': "https://img.youtube.com/vi/8DyN-ctdFow/0.jpg",
          'url': "https://www.youtube.com/watch?v=8DyN-ctdFow",
        };
        result.add(map2);
      } else if (jsonData[0]['position'] == 3.0) {
        var map3 = {
          'username': "DisneyJuniorUK",
          'title':
              "Minnie's Bow - Toons | Alarm Clocked Out | Disney Junior UK",
          'date': "Jan 11, 2016",
          'thum': "https://img.youtube.com/vi/ZezNGbJapvw/0.jpg",
          'url': "https://www.youtube.com/watch?v=ZezNGbJapvw",
        };
        result.add(map3);
      }
      var map4 = {
        'username': "OctoPy",
        'title': "Welcome to OctoPy!",
        'date': "Oct 13, 2021",
        'thum': "https://img.youtube.com/vi/_nQZipoissQ/0.jpg",
        'url': "https://www.youtube.com/watch?v=_nQZipoissQ",
      };
      result.add(map4);
      return result;
    }
  }

  checkUsername(String username) async {
    http.Response response = await http.post(
        Uri.parse("http://$server/api/checkUsername/$username/"),
        body: {});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    }
  }

  checkEmail(String email) async {
    http.Response response = await http
        .post(Uri.parse("http://$server/api/checkEmail/$email/"), body: {});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    }
  }

  getChartData(int user_id) async {
    http.Response response = await http.post(
        Uri.parse("http://$server/api/getPercentile/$user_id/"),
        body: {});

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      jsonData = json.decode(jsonData);
      var map = {
        "Phonics": jsonData[0]['crazeOnPhonicPointsPercentile'],
        "Phonemes": jsonData[0]['alphaHopperPointsPercentile'],
        "Vocabulary": jsonData[0]['wordKitPointsPercentile'],
        "Instruction": jsonData[0]['mazeCrazePointsPercentile'],
        "Reading": jsonData[0]['readingSpreePointsPercentile'],
      };
      return map;
    }
  }

  getLearning(int user_id) async {
    http.Response response = await http.post(
        Uri.parse("http://$server/api/getPercentile/$user_id/"),
        body: {});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = json.decode(response.body);
      jsonData = json.decode(jsonData);
      List result = [];
      if (jsonData[0]['crazeOnPhonicPointsPercentile'] < 0.5) {
        var map1 = {
          'username': "OctoPy",
          'title': "Alphabet with Octopy",
          'date': "Aug 19, 2021",
          'thum': "https://img.youtube.com/vi/bWidmwLKSo8/0.jpg",
          'url': "https://www.youtube.com/watch?v=bWidmwLKSo8",
        };
        result.add(map1);
      }
      if (jsonData[0]['wordKitPointsPercentile'] < 0.5) {
        var map2 = {
          'username': "Smile and Learn - English",
          'title': "Wild animals for kids - Vocabulary for kids",
          'date': "Jul 1, 2019",
          'thum': "https://img.youtube.com/vi/CA6Mofzh7jo/0.jpg",
          'url': "https://www.youtube.com/watch?v=CA6Mofzh7jo",
        };
        result.add(map2);
      }
      if (jsonData[0]['alphaHopperPointsPercentile'] < 0.5) {
        var map3 = {
          'username': "Gokidz Asia Academy",
          'title':
              "Vowels and Consonants Song | Preschool Lessons | Simple English Lessons | Fun Learning ESL",
          'date': "Sep 12, 2020",
          'thum': "https://img.youtube.com/vi/SAfn5x-mc24/0.jpg",
          'url': "https://www.youtube.com/watch?v=SAfn5x-mc24",
        };
        result.add(map3);
      }

      if (jsonData[0]['mazeCrazePointsPercentile'] < 0.5) {
        var map3 = {
          'username': "Kid-E-Cats",
          'title':
              "Kid-E-Cats | Following Instructions | Episode 77 | Cartoons for Kids",
          'date': "Mar 7, 2020",
          'thum': "https://img.youtube.com/vi/PFz9POflcPw/0.jpg",
          'url': "https://www.youtube.com/watch?v=PFz9POflcPw",
        };
        result.add(map3);
      }

      if (jsonData[0]['readingSpreePointsPercentile'] < 0.5) {
        var map3 = {
          'username': "Kids Academy",
          'title':
              "Learn How to Read Words | Reading for Preschool and Kindergarten | Kids Academy",
          'date': "Aug 29, 2018",
          'thum': "https://img.youtube.com/vi/izqfrq_vpv4/0.jpg",
          'url': "https://www.youtube.com/watch?v=izqfrq_vpv4",
        };
        var map33 = {
          'username': "OctoPy",
          'title': "Charlie and Bailey",
          'date': "Nov 15, 2021",
          'thum': "https://img.youtube.com/vi/5zZmD1_bM1w/0.jpg",
          'url': "https://www.youtube.com/watch?v=5zZmD1_bM1w",
        };
        result.add(map3);
        result.add(map33);
      }

      return result;
    }
  }
}
