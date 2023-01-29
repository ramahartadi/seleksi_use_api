import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_api/screens/books/books_screen.dart';
import 'package:simple_api/utils/rest_api.dart';
import 'package:http/http.dart' as http;

class EditBookController extends GetxController {
  TextEditingController isbnController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController publishedController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController pagesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> updateBook(idBook) async {
    final SharedPreferences? prefs = await _prefs;

    var headers = {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${prefs?.get('token')}'
    };
    try {
      var url = Uri.parse(RestApi.baseUrl +
          RestApi.bookApi.books +
          '/' +
          idBook.toString() +
          '/edit');
      Map body = {
        'isbn': isbnController.text,
        'title': titleController.text,
        'subtitle': subtitleController.text,
        'author': authorController.text,
        'published': publishedController.text,
        'publisher': publisherController.text,
        'pages': pagesController.text,
        'description': descriptionController.text,
        'website': websiteController.text
      };

      http.Response response =
          await http.put(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['message'] == "Book updated") {
          Get.offAll(BooksScreen());
        } else {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [Text(error.toString())],
          );
        },
      );
    }
  }
}
