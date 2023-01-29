import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_api/models/user.dart';
import 'package:simple_api/screens/auth/auth_screen.dart';
import 'package:simple_api/utils/rest_api.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<User> fetchUserData() async {
    final SharedPreferences? prefs = await _prefs;
    var headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${prefs?.get('token')}'
    };

    var url = Uri.parse(RestApi.baseUrl + RestApi.authApi.userInfo);

    http.Response response = await http.get(url, headers: headers);

    var data = jsonDecode(response.body.toString());

    print(data);
    if (response.statusCode == 200) {
      return User.fromJson(data);
    } else {
      return User.fromJson(data);
    }
  }

  Future logoutUser() async {
    final SharedPreferences? prefs = await _prefs;
    var headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${prefs?.get('token')}'
    };

    var url = Uri.parse(RestApi.baseUrl + RestApi.authApi.logout);

    http.Response response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      print(data);
      if (data['message'] == 'Logged out') {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove('token');
        Get.offAll(AuthScreen());
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } else {
      throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<User>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Text('${snapshot.data!.id}'),
                  Text(snapshot.data!.name),
                  Text(snapshot.data!.email),
                  Text('${snapshot.data!.emailVerifiedAt}'),
                  Text('${snapshot.data!.createdAt}'),
                  Text('${snapshot.data!.updatedAt}'),
                  ElevatedButton(
                    onPressed: () {
                      logoutUser();
                    },
                    child: Text('Log Out'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
