import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/Book.dart';
import 'package:flutter/cupertino.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  Future fetchBooks() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('books').get();
    final books =
        querySnapshot.docs.map((doc) => new Book(doc['title'])).toList();
    this.books = books;
    notifyListeners();
  }
}
