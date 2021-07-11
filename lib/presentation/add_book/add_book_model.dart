import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/Book.dart';
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
    // notifyListeners();
  }

  Future<void> updateBook(Book book) async {
    CollectionReference books = FirebaseFirestore.instance.collection('books');
    await books.doc(book.documentId).update({
      'title': this.title,
    });
    // notifyListeners();
  }
}
