import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String documentId;
  String title;

  Book(QueryDocumentSnapshot doc) {
    this.documentId = doc.id;
    this.title = doc['title'];
  }
}
