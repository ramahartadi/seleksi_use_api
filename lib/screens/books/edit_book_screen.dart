import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_api/controllers/edit_book_controller.dart';
import 'package:simple_api/models/books.dart';
import 'package:simple_api/screens/auth/widgets/input_widget.dart';
import 'package:simple_api/screens/auth/widgets/submit_button.dart';

class EditBookScreen extends StatefulWidget {
  final Datum book;
  const EditBookScreen({super.key, required this.book});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  EditBookController editBookController = Get.put(EditBookController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editBookController.isbnController.text = widget.book.isbn;
    editBookController.titleController.text = widget.book.title;
    editBookController.subtitleController.text = '${widget.book.subtitle}';
    editBookController.authorController.text = '${widget.book.author}';
    editBookController.publishedController.text = '${widget.book.published}';
    editBookController.publisherController.text = '${widget.book.publisher}';
    editBookController.pagesController.text = '${widget.book.pages}';
    editBookController.descriptionController.text =
        '${widget.book.description}';
    editBookController.websiteController.text = '${widget.book.website}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: editBookWidget()),
    );
  }

  Widget editBookWidget() {
    return Column(
      children: [
        InputTextFieldWidget(editBookController.isbnController, 'isbn'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(editBookController.titleController, 'title'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(editBookController.subtitleController, 'subtitle'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(editBookController.authorController, 'author'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            editBookController.publishedController, 'published'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            editBookController.publisherController, 'publisher'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(editBookController.pagesController, 'pages'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            editBookController.descriptionController, 'description'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(editBookController.websiteController, 'website'),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => editBookController.updateBook(widget.book.id),
          title: 'Edit',
        )
      ],
    );
  }
}
