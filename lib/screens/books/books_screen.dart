import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_api/models/books.dart';

import 'package:http/http.dart' as http;
import 'package:simple_api/screens/books/add_book_screen.dart';
import 'package:simple_api/screens/books/detail_book_screen.dart';
import 'package:simple_api/screens/books/profile.dart';
import 'package:simple_api/utils/rest_api.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<Books> fetchBooksData() async {
    final SharedPreferences? prefs = await _prefs;
    var headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${prefs?.get('token')}'
    };

    var url = Uri.parse(RestApi.baseUrl + RestApi.bookApi.books);

    http.Response response = await http.get(url, headers: headers);

    var data = jsonDecode(response.body.toString());

    print(data);
    if (response.statusCode == 200) {
      return Books.fromJson(data);
    } else {
      return Books.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(
                  () => (Profile()),
                );
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: FutureBuilder<Books>(
        future: fetchBooksData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.data.length,
              itemBuilder: (context, index1) {
                return ListTile(
                  title: Text(snapshot.data!.data[index1].title),
                  subtitle: snapshot.data!.data[index1].subtitle != null
                      ? Text(snapshot.data!.data[index1].subtitle)
                      : Container(),
                  onTap: () {
                    Get.to(() =>
                        DetailBookScreen(book: snapshot.data!.data[index1]));
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddBookScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
