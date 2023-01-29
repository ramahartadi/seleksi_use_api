import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_api/models/books.dart';
import 'package:simple_api/screens/books/books_screen.dart';
import 'package:simple_api/screens/books/edit_book_screen.dart';
import 'package:simple_api/utils/rest_api.dart';
import 'package:http/http.dart' as http;

class DetailBookScreen extends StatelessWidget {
  final Datum book;
  const DetailBookScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => EditBookScreen(book: book));
            },
            icon: Icon(
              Icons.edit,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () => _dialogBuilder(context, book.id),
            icon: Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: Container(
        child: Text(book.isbn),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, bookId) {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    void deleteBooksData() async {
      final SharedPreferences? prefs = await _prefs;
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs?.get('token')}'
      };
      var url = Uri.parse('${RestApi.baseUrl}${RestApi.bookApi.books}/$bookId');

      http.Response response = await http.delete(url, headers: headers);
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Anda akan menghapus buku ini'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Kembali'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Hapus'),
              onPressed: () {
                deleteBooksData();
                Get.offAll(() => BooksScreen());
              },
            ),
          ],
        );
      },
    );
  }
}
