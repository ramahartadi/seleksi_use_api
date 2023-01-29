import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_api/controllers/get_books.dart';

import 'auth/auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  BookController bookController = Get.put(
    BookController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () async {
              final SharedPreferences? prefs = await _prefs;
              prefs?.clear();
              Get.offAll(AuthScreen());
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ))
      ]),
      body: Center(
        child: Column(
          children: [
            Text('Welcome home'),
            TextButton(
              onPressed: () async {
                // final SharedPreferences? prefs = await _prefs;
                // print(
                //   prefs?.get('token'),
                // );
                // bookController.getBooks(
                //   prefs?.get('token'),
                // );
              },
              child: Text('Go to Books Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
