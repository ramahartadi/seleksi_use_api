import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_api/controllers/add_book_controller.dart';
import 'package:simple_api/models/books.dart';
import 'package:simple_api/screens/auth/widgets/input_widget.dart';
import 'package:simple_api/screens/auth/widgets/submit_button.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  AddBookController addBookController = Get.put(AddBookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(36), child: AddBookWidget())),
    );
  }

  Widget AddBookWidget() {
    return Column(
      children: [
        InputTextFieldWidget(addBookController.isbnController, 'isbn'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(addBookController.titleController, 'title'),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => addBookController.addBook(),
          title: 'Add',
        )
      ],
    );
  }
}
