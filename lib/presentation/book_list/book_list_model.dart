import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/Book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  Future fetchBooks() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('books').get();
    books = querySnapshot.docs.map((doc) => new Book(doc)).toList();
    books.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    this.books = books;
    notifyListeners();
  }

  Future deleteBook(Book book) async {
    CollectionReference books = FirebaseFirestore.instance.collection('books');
    await books.doc(book.documentId).delete();
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
