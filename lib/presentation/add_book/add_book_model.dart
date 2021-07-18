import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:coriander/domain/Book.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddBookModel extends ChangeNotifier {
  String title = '';
  final _picker = ImagePicker();
  File imageFile;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  Future<void> showImagePicker() async {
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future<void> addBook() async {
    if (title.isEmpty) {
      throw ('本のタイトルを入力して下さい。');
    }

    String url = await _uploadImage();

    CollectionReference books = FirebaseFirestore.instance.collection('books');
    await books.add({
      'title': this.title,
      'imageUrl': url,
      'createdAt': Timestamp.now(),
    });

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateBook(Book book) async {
    CollectionReference books = FirebaseFirestore.instance.collection('books');
    await books.doc(book.documentId).update({
      'title': this.title,
    });
  }

  Future<String> _uploadImage() async {
    if (imageFile == null) {
      return '';
    }

    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref('books/$title')
        .putFile(imageFile);

    try {
      firebase_storage.TaskSnapshot snapshot = await task;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e.toString());
      return '';
    }
  }
}
