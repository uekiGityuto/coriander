import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ConfirmModel extends ChangeNotifier {
  bool confirm() {
    User user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      return true;
    }
    return false;
  }
}
