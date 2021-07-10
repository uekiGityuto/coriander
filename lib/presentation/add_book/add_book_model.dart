import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddBookModel extends ChangeNotifier {
  String title = '';

  Future<void> addBook() async {
    if (title.isEmpty) {
      throw ('本のタイトルを入力して下さい。');
    }
    CollectionReference books = FirebaseFirestore.instance.collection('books');
    await books.add({
      'title': this.title,
    });
    notifyListeners();
  }
}
