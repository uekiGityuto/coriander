import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String documentId = '';
  String title = '';
  String imageUrl = '';

  Book(QueryDocumentSnapshot doc) {
    this.documentId = doc.id;
    this.title = doc['title'];
    this.imageUrl = doc['imageUrl'];
  }
}
