import 'dart:async';
import 'dart:math';
import 'package:octopy/User.dart';

import '/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '/Child.dart';

class AuthService {
  //  String server = "10.0.2.2:8000";
  String server = "104.215.189.210";
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

  // verifyUser() async {
  //   bool ff = false;
  //   http.Response response = await http.post(
  //       Uri.parse(
  //           "http://$server/api/verifyUser/${user.username}/${user.password}/"),
  //       body: {});
  //   session_id = int.parse(response.body);
  //   user.id = int.parse(response.body);
  //   print(int.parse(response.body));
  //   setUser(user.id);
  //   if (session_id > 0) {
  //     flag = true;
  //     ff = true;
  //   }
  //   return ff;
  // }
  verifyUser() async {
    bool ff = false;
    var data = new Map<String, String>();
    data['username'] = user.username;
    data['password'] = user.password;
    http.Response response = await http
        .post(Uri.parse("http://$server/api/verifyUser/"), body: data);
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
  // regiterUser(String firstname, String lastname, int age, String username,
  //     String email, String password) async {
  //   http.Response response = await http.post(
  //       Uri.parse(
  //           "http://$server/api/registerUser/$firstname/$lastname/$age/$username/$email/$password/"),
  //       body: {});
  //   // return firstname;
  // }

  regiterUser(String firstname, String lastname, int age, String username,
      String email, String password) async {
    var data = new Map<String, String>();
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['age'] = age.toString();
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;

    http.Response response = await http
        .post(Uri.parse("http://$server/api/registerUser/"), body: data);
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

  // updateUser(int user_id, String firstname, String lastname, int age,
  //     String username, String email, String password) async {
  //   http.Response response = await http.post(
  //       Uri.parse(
  //           "http://$server/api/updateUser/$user_id/$firstname/$lastname/$age/$username/$email/$password/"),
  //       body: {});
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return true;
  //   }
  // }
  updateUser(int user_id, String firstname, String lastname, int age,
      String username, String email, String password) async {
    var data = new Map<String, String>();
    data['user_id'] = user_id.toString();
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['age'] = age.toString();
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;

    http.Response response = await http
        .post(Uri.parse("http://$server/api/updateUser/"), body: data);
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
          'username': "OctoPy",
          'title': "A Birthday Gift",
          'date': "Nov 13, 2021",
          'thum': "https://img.youtube.com/vi/DGU5N_WcJk8/0.jpg",
          'url': "https://www.youtube.com/watch?v=DGU5N_WcJk8",
        };
        result.add(map1);
      } else if (jsonData[0]['position'] == 2.0) {
        var map2 = {
          'username': "OctoPy",
          'title': "Sight Words",
          'date': "Nov 23, 2021",
          'thum': "https://img.youtube.com/vi/tG6VwqlCaLI/0.jpg",
          'url': "https://www.youtube.com/watch?v=tG6VwqlCaLI",
        };
        result.add(map2);
      } else if (jsonData[0]['position'] == 3.0) {
        var map3 = {
          'username': "OctoPy",
          'title': "Guess the Word",
          'date': "Nov 23, 2021",
          'thum': "https://img.youtube.com/vi/ykSCoiG1DpY/0.jpg",
          'url': "https://www.youtube.com/watch?v=ykSCoiG1DpY",
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
          'username': "OctoPy",
          'title': "Sight Words for Kids!",
          'date': "Nov 19, 2021",
          'thum': "https://img.youtube.com/vi/0v7fD5GFxCg/0.jpg",
          'url': "https://www.youtube.com/watch?v=0v7fD5GFxCg",
        };
        var map22 = {
          'username': "Smile and Learn - English",
          'title': "Wild animals for kids - Vocabulary for kids",
          'date': "Jul 1, 2019",
          'thum': "https://img.youtube.com/vi/CA6Mofzh7jo/0.jpg",
          'url': "https://www.youtube.com/watch?v=CA6Mofzh7jo",
        };
        result.add(map2);
        result.add(map22);
      }
      if (jsonData[0]['alphaHopperPointsPercentile'] < 0.5) {
        var map3 = {
          'username': "OctoPy",
          'title': "Consonants",
          'date': "Nov 18, 2021",
          'thum': "https://img.youtube.com/vi/HScZKrB-nFQ/0.jpg",
          'url': "https://www.youtube.com/watch?v=HScZKrB-nFQ",
        };
        var map33 = {
          'username': "Gokidz Asia Academy",
          'title':
              "Vowels and Consonants Song | Preschool Lessons | Simple English Lessons | Fun Learning ESL",
          'date': "Sep 12, 2020",
          'thum': "https://img.youtube.com/vi/SAfn5x-mc24/0.jpg",
          'url': "https://www.youtube.com/watch?v=SAfn5x-mc24",
        };
        result.add(map3);
        result.add(map33);
      }

      if (jsonData[0]['mazeCrazePointsPercentile'] < 0.5) {
        var map3 = {
          'username': "OctoPy",
          'title': "Fruits And Vegatables",
          'date': "Nov 18, 2021",
          'thum': "https://img.youtube.com/vi/35Lybtv-rPY/0.jpg",
          'url': "https://www.youtube.com/watch?v=35Lybtv-rPY",
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
          'date': "Nov 18, 2021",
          'thum': "https://img.youtube.com/vi/vvKJlYU6rsM/0.jpg",
          'url': "https://www.youtube.com/watch?v=vvKJlYU6rsM",
        };
        result.add(map33);
        result.add(map3);
      }

      return result;
    }
  }
}
